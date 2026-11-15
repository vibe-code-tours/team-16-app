"""Unit tests for the PDF text helpers. They need no downloaded exam papers."""
from extract_itpec import ANSWER_NUMBER_RE, INSTRUCTION_PAGE_RE, clean, split_choices


def test_clean_removes_page_number_footer():
    assert clean("Using public key cryptography\n\n - 6 -") == "Using public key cryptography"
    assert clean("7\n\n – 3 –") == "7"


def test_clean_keeps_dashes_inside_a_sentence():
    assert clean("x - 3 - y") == "x - 3 - y"


def test_split_choices_finds_four_choices():
    question, choices = split_choices("Q19. Which API is used?\n\n a) HTML b) Java VM c) JDBC d) SQL")
    assert question == "Q19. Which API is used?"
    assert [choice["label"] for choice in choices] == ["a", "b", "c", "d"]
    assert choices[2]["text"] == "JDBC"


def test_split_choices_ignores_a_stray_letter_inside_a_choice():
    chunk = (
        "Q24. Which explains augmented reality?\n\n"
        " a) A person experiences worlds that do not exist.\n"
        " b) By constructing a 3D virtual space, the user can walk around.\n"
        " c) Computer-generated information is overlaid on the physical world.\n"
        " d) The viewer watches a video recorded in the past."
    )
    _question, choices = split_choices(chunk)
    assert [choice["label"] for choice in choices] == ["a", "b", "c", "d"]
    assert "3D virtual space" in choices[1]["text"]


def test_split_choices_returns_no_choices_when_labels_are_incomplete():
    _question, choices = split_choices("Q50. Pick one.\n a) One b) Two c) Three c) Four")
    assert choices == []


def test_answer_key_accepts_question_numbers_up_to_eighty():
    assert ANSWER_NUMBER_RE.fullmatch("60")
    assert ANSWER_NUMBER_RE.fullmatch("80")
    assert not ANSWER_NUMBER_RE.fullmatch("81")
    assert not ANSWER_NUMBER_RE.fullmatch("0")


def test_instruction_pages_are_recognised():
    assert INSTRUCTION_PAGE_RE.search("[Sample Question]\n Q1. Which of the following should be used")
    assert not INSTRUCTION_PAGE_RE.search("Q1. Which of the following is equivalent")
