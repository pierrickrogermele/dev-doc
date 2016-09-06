cantor-set-level = 6
sierpinski-square-level = 6
sierpinski-triangle-level = 6
von-koch-triangles-level = 6
von-koch-squares-level = 6

scripts = cantor-set sierpinski-square sierpinski-triangle von-koch-triangles von-koch-squares

all: $(addsuffix -01.png,$(scripts))

%-01.png: %
	./$< $($<-level)

clean:
	$(RM) *.png *.pyc

.PHONY: all clean
