#!/usr/bin/env python3
"""Upload extracted ITPEC assets and idempotently seed Supabase.

Required environment variables: SUPABASE_URL and SUPABASE_SERVICE_ROLE_KEY.
Apply migrations through 003 before running this script.
"""
from __future__ import annotations

import json
import mimetypes
import os
import sys
import urllib.error
import urllib.parse
import urllib.request
from pathlib import Path
import argparse


def request(method: str, url: str, key: str, body: bytes | None = None, headers: dict | None = None):
    merged = {"apikey": key, "Authorization": f"Bearer {key}", **(headers or {})}
    req = urllib.request.Request(url, data=body, method=method, headers=merged)
    try:
        with urllib.request.urlopen(req) as response:
            payload = response.read()
            return json.loads(payload) if payload else None
    except urllib.error.HTTPError as exc:
        detail = exc.read().decode("utf-8", "replace")
        raise RuntimeError(f"Supabase request failed ({exc.code}): {detail}") from exc


def main() -> None:
    parser = argparse.ArgumentParser()
    parser.add_argument("output_dir", type=Path)
    parser.add_argument("--pdf-dir", type=Path, required=True)
    args = parser.parse_args()
    root = args.output_dir
    url = os.environ.get("SUPABASE_URL", "").rstrip("/")
    key = os.environ.get("SUPABASE_SERVICE_ROLE_KEY", "")
    if not url or not key:
        raise SystemExit("Set SUPABASE_URL and SUPABASE_SERVICE_ROLE_KEY (never commit either value).")

    subtopics = request("GET", f"{url}/rest/v1/subtopics?select=id&limit=1", key)
    if not subtopics:
        raise SystemExit("No subtopics exist; apply 001_initial_schema.sql first.")
    fallback_subtopic_id = subtopics[0]["id"]
    rows = json.loads((root / "questions.json").read_text())

    # Upload each immutable source document once; question rows reference it.
    pdf_names = sorted({
        doc["filename"]
        for row in rows
        for doc in row["ref_doc"].values()
    })
    for filename in pdf_names:
        source = args.pdf_dir / filename
        if not source.is_file():
            raise SystemExit(f"Missing reference PDF: {source}")
        storage_path = f"2025-october/{filename}"
        endpoint = f"{url}/storage/v1/object/exam-reference-docs/{urllib.parse.quote(storage_path)}"
        request("POST", endpoint, key, source.read_bytes(), {
            "Content-Type": "application/pdf", "x-upsert": "true",
        })

    for image in (root / "images").rglob("*.webp"):
        relative = image.relative_to(root / "images")
        storage_path = f"2025-october/{relative.as_posix()}"
        endpoint = f"{url}/storage/v1/object/question-images/{urllib.parse.quote(storage_path)}"
        request("POST", endpoint, key, image.read_bytes(), {
            "Content-Type": mimetypes.guess_type(image.name)[0] or "image/png",
            "x-upsert": "true",
        })

    for row in rows:
        row["subtopic_id"] = fallback_subtopic_id
        row["images"] = [f"{url}/storage/v1/object/public/question-images/{path}" for path in row["images"]]
        for document in row["ref_doc"].values():
            document["url"] = f"{url}/storage/v1/object/public/exam-reference-docs/{document['storage_path']}"
    endpoint = f"{url}/rest/v1/questions?on_conflict=exam_session,subject,question_number"
    for start in range(0, len(rows), 20):
        request("POST", endpoint, key, json.dumps(rows[start:start + 20]).encode(), {
            "Content-Type": "application/json",
            "Prefer": "resolution=merge-duplicates,return=minimal",
        })
    print(f"Uploaded assets and upserted {len(rows)} questions.")


if __name__ == "__main__":
    main()
