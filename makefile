# $Revision: 1.6 $
# -----------------------------------------------------------------------------
# Copyright 2017-2019,2022 Thomas E. Dickey
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in all
# copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
# SOFTWARE.
# -----------------------------------------------------------------------------
ALL	= \
	uniset.out \
	uniset_cjk.out \
	uniset_ctl.out \
	uniset_dbl.out \
	uniset_unk.out

all:	$(ALL)

uniset.out: UnicodeData.txt
	./run-uniset >$@

uniset_cjk.out: UnicodeData.txt WIDTH-A
	./run-uniset_cjk >$@

uniset_ctl.out: UnicodeData.txt
	./run-uniset_ctl >$@

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
	@$(SHELL) -c 'for n in $(ALL:.out=);do echo Testing $$n; ./run-$$n >$$n.tmp;diff -u $$n.out $$n.tmp;done'
	@$(SHELL) -c 'for n in WIDTH-[AW];do echo Testing $$n; ./run-$$n >$$n.tmp;diff -u $$n $$n.tmp;done'
	@rm -f *.tmp
