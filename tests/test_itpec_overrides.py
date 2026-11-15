import pymupdf
import pytest

from itpec_overrides import REVIEWED_METHOD, apply_overrides, replace_in


def make_pdf(path):
    doc = pymupdf.open()
    page = doc.new_page()
    page.insert_text((72, 100), "Q1. A drawn question")
    page.draw_rect(pymupdf.Rect(100, 150, 200, 220))
    doc.save(path)


def make_question():
    return {
        "exam_session": "2025-april", "subject": "A", "question_number": 1,
        "question_text": "Q1. 2000x  minimize",
        "choices": [{"label": label, "text": ""} for label in "abcd"],
        "content_blocks": [{"type": "text", "page": 1, "text": "Q1. 2000x  minimize"}],
        "images": ["2025-april-a-q01-figure1.webp"],
        "extraction_method": "native_text",
    }


def test_replace_in_reaches_nested_strings():
    value = {"a": ["x  y", {"b": ""}], "n": 3}
    assert replace_in(value, [{"find": "", "replace": "→"}]) == {"a": ["x → y", {"b": "→"}], "n": 3}


def test_replacements_fix_text_and_content_blocks(tmp_path):
    make_pdf(tmp_path / "questions.pdf")
    questions = [make_question()]
    overrides = {"1": {"note": "arrow", "replacements": [{"find": "", "replace": "→"}]}}
    assert apply_overrides(questions, overrides, tmp_path / "questions.pdf", tmp_path) == 1
    assert questions[0]["question_text"] == "Q1. 2000x → minimize"
    assert questions[0]["content_blocks"][0]["text"] == "Q1. 2000x → minimize"
    assert questions[0]["extraction_method"] == REVIEWED_METHOD


def test_question_text_override_replaces_raw_content_blocks(tmp_path):
    make_pdf(tmp_path / "questions.pdf")
    questions = [make_question()]
    apply_overrides(questions, {"1": {"question_text": "Q1. Corrected"}}, tmp_path / "questions.pdf", tmp_path)
    assert questions[0]["content_blocks"] == [{"type": "text", "text": "Q1. Corrected"}]


def test_choice_and_question_figures_are_rendered(tmp_path):
    make_pdf(tmp_path / "questions.pdf")
    (tmp_path / "2025-april-a-q01-figure1.webp").write_bytes(b"stale")
    (tmp_path / "2025-april-a-q01-figure2.webp").write_bytes(b"stale")
    region = {"page": 1, "rect": [95, 145, 205, 225]}
    overrides = {"1": {
        "figures": [region],
        "choices": [{"label": label, "text": "", "figure": region} for label in "abcd"],
    }}
    questions = [make_question()]
    apply_overrides(questions, overrides, tmp_path / "questions.pdf", tmp_path)

    assert questions[0]["images"] == ["2025-april-a-q01-figure1.webp"]
    assert not (tmp_path / "2025-april-a-q01-figure2.webp").exists()
    assert (tmp_path / "2025-april-a-q01-figure1.webp").stat().st_size > len(b"stale")
    assert [choice["image"] for choice in questions[0]["choices"]] == [
        f"2025-april-a-q01-choice-{label}.webp" for label in "abcd"
    ]
    assert all("figure" not in choice for choice in questions[0]["choices"])
    assert all((tmp_path / choice["image"]).exists() for choice in questions[0]["choices"])


def test_override_for_a_missing_question_is_an_error(tmp_path):
    make_pdf(tmp_path / "questions.pdf")
    with pytest.raises(ValueError, match="do not exist"):
        apply_overrides([make_question()], {"9": {"question_text": "x"}}, tmp_path / "questions.pdf", tmp_path)
