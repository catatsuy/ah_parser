PYTHON=python3.3
#OPT=-m pdb
SAMPLE=sample.cc
TEST=test.py

SRC=ah.g

.PHONY: compile
compile:
	java -jar /usr/local/lib/antlr-3.5-complete.jar $(SRC)

.PHONY: test
test:
	$(PYTHON) $(OPT) $(TEST) < $(SAMPLE)

.PHONY: clean
clean:
	rm -rf *.pyc __pycache__
