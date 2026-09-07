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

# pixi shell -e py314
# pixi shell -e py312
test:
	flake8 *.py --count --select=E9,F63,F7,F82 --show-source --statistics
	PYTHON_COLORS=0 pixi run -e py312 python -W error doc/test_plac.py
	PYTHON_COLORS=0 pixi run -e py314 python -W error doc/test_plac.py

generate:
	PYTHON_COLORS=0 python -W error doc/generate_help.py

clean:
	rm -rf docs/
