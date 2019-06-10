ALL	= \
	uniset.out \
	uniset_cjk.out \
	uniset_dbl.out \
	uniset_unk.out

all:	$(ALL)

uniset.out: UnicodeData.txt
	./run-uniset >$@

uniset_cjk.out: UnicodeData.txt WIDTH-A
	./run-uniset_cjk >$@

uniset_dbl.out: UnicodeData.txt WIDTH-W
	./run-uniset_dbl >$@

uniset_unk.out: UnicodeData.txt
	./run-uniset_unk >$@

WIDTH-A: EastAsianWidth.txt
	rm -f $@
	./run-$@ >$@

WIDTH-W: EastAsianWidth.txt
	rm -f $@
	./run-$@ >$@

clean:
	rm -f $(ALL)

clobber: clean
	rm -f WIDTH-[AW]

check:
	@$(SHELL) -c 'for n in uniset uniset_cjk uniset_unk;do echo Testing $$n; ./run-$$n >$$n.tmp;diff -u $$n.out $$n.tmp;done'
	@$(SHELL) -c 'for n in WIDTH-[AW];do echo Testing $$n; ./run-$$n >$$n.tmp;diff -u $$n $$n.tmp;done'
	@rm -f *.tmp
