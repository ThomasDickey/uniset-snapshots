ALL	= \
	uniset.out \
	uniset_cjk.out

all:	$(ALL)

uniset.out: UnicodeData.txt
	./run-uniset >$@

uniset_cjk.out: UnicodeData.txt WIDTH-A
	./run-uniset_cjk >$@

WIDTH-A: EastAsianWidth.txt
	rm -f $@
	./run-WIDTH-A >$@

clean:
	rm -f $(ALL)

clobber: clean
	rm -f WIDTH-A

check:
	@$(SHELL) -c 'for n in uniset uniset_cjk;do echo Testing $$n; ./run-$$n >$$n.tmp;diff -u $$n.out $$n.tmp;done'
	@$(SHELL) -c 'for n in WIDTH-A;do echo Testing $$n; ./run-$$n >$$n.tmp;diff -u $$n $$n.tmp;done'
	@rm -f *.tmp
