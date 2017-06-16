ALL	= \
	uniset.out \
	uniset_cjk.out \
	uniset_unk.out

all:	$(ALL)

uniset.out: UnicodeData.txt
	./run-uniset >$@

uniset_cjk.out: UnicodeData.txt WIDTH-A
	./run-uniset_cjk >$@

uniset_unk.out: UnicodeData.txt
	./run-uniset_unk >$@

WIDTH-A: EastAsianWidth.txt
	rm -f $@
	./run-WIDTH-A >$@

clean:
	rm -f $(ALL)

clobber: clean
	rm -f WIDTH-A

check:
	@$(SHELL) -c 'for n in uniset uniset_cjk uniset_unk;do echo Testing $$n; ./run-$$n >$$n.tmp;diff -u $$n.out $$n.tmp;done'
	@$(SHELL) -c 'for n in WIDTH-A;do echo Testing $$n; ./run-$$n >$$n.tmp;diff -u $$n $$n.tmp;done'
	@rm -f *.tmp
