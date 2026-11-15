import json

from generate_exam_seed_sql import build_sql, literal, terms_in_manifest


def write_paper(resources, name, subject, numbers, enrich=True):
    session = "-".join(name.split("-")[:2]).lower()
    rows = [{
        "exam_session": session, "subject": subject, "question_number": number,
        "question_text": f"Q{number}. What's the output?",
        "choices": [{"label": label, "text": f"choice {label}"} for label in "abcd"],
        "correct_answer": "b", "answer_key": {"value": "b"}, "images": [],
        "content_blocks": [], "source_pages": [3], "source_citation": f"(2025S, FE, Subject-{subject}, Q{number})",
        "source_file": "questions.pdf", "source_text": "raw", "extraction_method": "native_text",
        "extraction_version": "3.0", "ref_doc": {},
    } for number in numbers]
    (resources / name).mkdir(parents=True)
    (resources / name / "questions.json").write_text(json.dumps(rows))
    if enrich:
        entries = {str(number): {
            "subtopic_slug": "algorithms", "confidence": 0.8,
            "explanation": "It's b because the loop runs twice.",
        } for number in numbers}
        (resources / "enrichment").mkdir(exist_ok=True)
        (resources / "enrichment" / f"{name}.json").write_text(json.dumps({"questions": entries}))


def make_resources(tmp_path, names=("2025-April-A", "2025-April-B")):
    for name in names:
        write_paper(tmp_path, name, name[-1], [1, 2])
    manifest = [{"name": name, "subject": name[-1]} for name in names]
    (tmp_path / "index.json").write_text(json.dumps(manifest))
    return tmp_path


def test_literal_escapes_single_quotes_and_nulls():
    assert literal("it's") == "'it''s'"
    assert literal(None) == "NULL"


def test_terms_are_ordered_by_year_then_april_before_october(tmp_path):
    names = ("2022-October-A", "2022-April-A", "2021-October-A")
    (tmp_path / "index.json").write_text(json.dumps([{"name": name} for name in names]))
    assert terms_in_manifest(tmp_path) == [(2021, "October"), (2022, "April"), (2022, "October")]


def test_all_papers_go_into_one_transaction(tmp_path):
    sql, total = build_sql(make_resources(tmp_path), [(2025, "April")])
    assert total == 4
    assert sql.count("BEGIN;") == 1 and sql.rstrip().endswith("COMMIT;")
    assert sql.count("INSERT INTO questions (") == 2
    assert sql.count("INSERT INTO exams (") == 2


def test_question_text_with_a_quote_is_escaped(tmp_path):
    sql, _total = build_sql(make_resources(tmp_path), [(2025, "April")])
    assert "'Q1. What''s the output?'" in sql


def test_explanation_and_subtopic_are_inserted_and_refreshed_on_conflict(tmp_path):
    sql, _total = build_sql(make_resources(tmp_path), [(2025, "April")])
    assert "'It''s b because the loop runs twice.'" in sql
    assert "(SELECT id FROM subtopics WHERE slug = 'algorithms')" in sql
    assert "explanation = EXCLUDED.explanation," in sql
    assert "subtopic_id = EXCLUDED.subtopic_id," in sql
    assert "times_answered" not in sql


def test_each_question_gets_one_primary_subtopic_link(tmp_path):
    sql, _total = build_sql(make_resources(tmp_path), [(2025, "April")])
    assert "DELETE FROM question_subtopics" in sql
    assert "SELECT q.id, s.id, true, v.confidence, 'llm'" in sql
    assert "(1, 'algorithms', 0.800)" in sql
    assert "AND q.exam_session = '2025-april' AND q.subject = 'A'" in sql
    assert "SELECT id FROM questions WHERE exam_session = '2025-april' AND subject = 'A'" in sql


def test_exam_time_limits_follow_the_paper_format(tmp_path):
    resources = make_resources(tmp_path, ("2023-October-A", "2023-October-B", "2025-April-A", "2025-April-B"))
    sql, _total = build_sql(resources, [(2023, "October"), (2025, "April")])
    assert "'2023 October FE Subject A', 2, 150, 5, true" in sql
    assert "'2025 April FE Subject A', 2, 90, 5, true" in sql
    assert "'2025 April FE Subject B', 2, 100, 5, true" in sql


def test_paper_without_enrichment_still_generates_with_null_subtopic(tmp_path):
    write_paper(tmp_path, "2025-April-A", "A", [1], enrich=False)
    write_paper(tmp_path, "2025-April-B", "B", [1], enrich=False)
    sql, _total = build_sql(tmp_path, [(2025, "April")])
    assert "INSERT INTO question_subtopics" not in sql
    assert "  NULL,\n  NULL,\n  'medium'" in sql
