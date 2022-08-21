import pytest

from src import main


def test_function_one() -> None:
    assert main.function_one() == 1


def test_function_two() -> None:
    assert main.function_two() == 2


def test_function_four() -> None:
    assert main.function_four() == 4


def test_function_five() -> None:
    assert main.function_five() == 5


@pytest.mark.integration
def test_function_six() -> None:
    assert main.function_six() == 6
