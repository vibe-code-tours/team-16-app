import json
from pathlib import Path


def test_generated_dataset_is_complete_and_answerable():
    path = Path("scripts/output/2025A_FE/questions.json")
    if not path.exists():
        return
    rows = json.loads(path.read_text())
    assert len(rows) == 80
    assert len({(q["subject"], q["question_number"]) for q in rows}) == 80
    assert {q["subject"] for q in rows} == {"A", "B"}
    for question in rows:
        assert question["question_text"]
        assert question["correct_answer"] in {c["label"] for c in question["choices"]}
        assert question["source_pages"]
        assert question["content_blocks"]
        assert question["ref_doc"]["question_pdf"]["filename"].endswith("_Questions.pdf")
        assert question["ref_doc"]["answer_pdf"]["filename"].endswith("_Answers.pdf")
        assert all(block["type"] in {"text", "code", "table", "prompt", "context", "answer_table"} for block in question["content_blocks"])

    q4 = next(q for q in rows if q["subject"] == "A" and q["question_number"] == 4)
    assert len(q4["images"]) == 1
    q6 = next(q for q in rows if q["subject"] == "A" and q["question_number"] == 6)
    assert len(q6["images"]) == 1
    q8 = next(q for q in rows if q["subject"] == "A" and q["question_number"] == 8)
    assert len(q8["images"]) == 1
    q13 = next(q for q in rows if q["subject"] == "A" and q["question_number"] == 13)
    assert q13["images"] == []

    b2 = next(q for q in rows if q["subject"] == "B" and q["question_number"] == 2)
    assert [block["type"] for block in b2["content_blocks"]] == ["prompt", "context", "code", "answer_table"]
    assert "***A***" in b2["content_blocks"][2]["text"]
    assert b2["choices"][2]["values"] == {"A": "arr[i] = arr[j]", "B": "m_c < c"}
    b1 = next(q for q in rows if q["subject"] == "B" and q["question_number"] == 1)
    assert b1["images"] == []
    b6 = next(q for q in rows if q["subject"] == "B" and q["question_number"] == 6)
    assert b6["images"] == []
    b9 = next(q for q in rows if q["subject"] == "B" and q["question_number"] == 9)
    assert len(b9["images"]) >= 1
