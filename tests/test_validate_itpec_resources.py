from validate_itpec_resources import (
    damaged_characters,
    validate_enrichment,
    validate_paper,
    validate_question,
)


def make_question(number=1, **changes):
    question = {
        "question_number": number,
        "subject": "A",
        "question_text": f"Q{number}. What is 2 + 2?",
        "source_text": f"Q{number}. What is 2 + 2? a) 3 b) 4 c) 5 d) 6",
        "choices": [{"label": label, "text": text} for label, text in zip("abcd", "3456")],
        "correct_answer": "b",
        "answer_key": {"value": "b"},
        "images": [],
        "content_blocks": [{"type": "text", "text": f"Q{number}. What is 2 + 2?"}],
    }
    question.update(changes)
    return question


def codes(failures):
    return {failure.code for failure in failures}


def test_valid_question_has_no_failures():
    assert validate_question("2025-April-A", make_question(), set()) == []


def test_sample_question_is_rejected():
    question = make_question(source_text="[Sample Question] Q1. Which of the following ...")
    assert "sample-question" in codes(validate_question("p", question, set()))


def test_missing_choices_are_rejected():
    question = make_question(choices=[])
    assert {"choice-labels", "answer-mismatch"} <= codes(validate_question("p", question, set()))


def test_empty_choice_text_is_rejected_unless_it_has_an_image():
    choices = [{"label": label, "text": ""} for label in "abcd"]
    assert "empty-choice" in codes(validate_question("p", make_question(choices=choices), set()))
    with_images = [{"label": label, "text": "", "image": f"q-choice-{label}.webp"} for label in "abcd"]
    names = {choice["image"] for choice in with_images}
    assert validate_question("p", make_question(choices=with_images), names) == []


def test_answer_that_matches_no_choice_is_rejected():
    assert "answer-mismatch" in codes(validate_question("p", make_question(correct_answer="e"), set()))


def test_text_from_a_broken_font_map_is_rejected():
    for damaged in ("ܣ + ܤ", "2000x  minimize", "25 ≤ \U0001d465 < 50"):
        question = make_question(question_text=f"Q1. {damaged}")
        assert "damaged-text" in codes(validate_question("p", question, set())), damaged


def test_ordinary_maths_symbols_are_accepted():
    assert damaged_characters("A̅ ∩ B ≤ α → x² ∑ √ • “quoted”") == []


def test_page_footer_in_a_choice_is_rejected():
    choices = make_question()["choices"]
    choices[3] = {"label": "d", "text": "6\n\n – 4 –"}
    assert "page-footer" in codes(validate_question("p", make_question(choices=choices), set()))


def test_missing_figure_file_is_rejected():
    question = make_question(images=["2025-april-a-q01-figure1.webp"])
    assert "missing-image" in codes(validate_question("p", question, set()))
    assert validate_question("p", question, {"2025-april-a-q01-figure1.webp"}) == []


def test_question_that_swallowed_later_questions_is_rejected():
    question = make_question(question_text="Q60. " + "x" * 3000)
    assert "oversized-question" in codes(validate_question("p", question, set()))


def test_legacy_subject_b_is_checked_by_answer_parts():
    question = make_question(
        subject="B", choices=[{"label": "a", "text": "one"}],
        answer_key={"parts": [{"subquestion": 1, "blank": "A", "answer": "c"}]}, correct_answer="[...]",
    )
    assert validate_question("p", question, set()) == []
    question["answer_key"] = {"parts": []}
    assert "answer-mismatch" in codes(validate_question("p", question, set()))


def test_paper_with_wrong_question_count_is_rejected():
    questions = [make_question(number) for number in range(1, 60)]
    assert "question-count" in codes(validate_paper("p", "A", questions, set()))


def test_paper_with_a_gap_in_numbering_is_rejected():
    questions = [make_question(number) for number in range(1, 61)]
    questions[10]["question_number"] = 99
    assert "question-numbers" in codes(validate_paper("p", "A", questions, set()))


def test_complete_papers_of_sixty_and_eighty_questions_pass():
    for count in (60, 80):
        assert validate_paper("p", "A", [make_question(n) for n in range(1, count + 1)], set()) == []


GOOD_ENTRY = {
    "subtopic_slug": "algorithms", "confidence": 0.9,
    "explanation": "Two plus two equals four, so the choice showing 4 is correct.",
}


def test_enrichment_must_cover_every_question():
    questions = [make_question(1), make_question(2)]
    failures = validate_enrichment("p", questions, {"questions": {"1": GOOD_ENTRY}})
    assert [(failure.question_number, failure.code) for failure in failures] == [(2, "enrichment-missing")]
    assert codes(validate_enrichment("p", questions, None)) == {"enrichment-missing"}


def test_enrichment_rejects_unknown_subtopic_short_explanation_and_bad_confidence():
    entries = {
        "1": {**GOOD_ENTRY, "subtopic_slug": "quantum"},
        "2": {**GOOD_ENTRY, "explanation": "b"},
        "3": {**GOOD_ENTRY, "confidence": 1.5},
    }
    questions = [make_question(1), make_question(2), make_question(3)]
    assert codes(validate_enrichment("p", questions, {"questions": entries})) == {
        "enrichment-subtopic", "enrichment-explanation", "enrichment-confidence",
    }


def test_enrichment_for_a_question_that_does_not_exist_is_rejected():
    failures = validate_enrichment("p", [make_question(1)], {"questions": {"1": GOOD_ENTRY, "7": GOOD_ENTRY}})
    assert codes(failures) == {"enrichment-extra"}
