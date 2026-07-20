.PHONY: \
  default \
  dist \
  upload \
  test \
  clean

default:
	sphinx-build doc docs

dist: plac_core.py plac_ext.py
	python setup.py build sdist bdist_wheel

pypi:
	rm -rf build/* dist/*
	python setup.py sdist bdist_wheel
	python -m twine upload --repository pypi dist/*

test:
	PYTHON_COLORS=0 python -W error doc/test_plac.py

generate:
	PYTHON_COLORS=0 python -W error doc/generate_help.py

clean:
	rm -rf docs/
