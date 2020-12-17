HOSTNAME := $(shell hostname)
COOKIE := mysharedcookie

all:

sh1: postman.beam
	erl -sname $@ -setcookie $(COOKIE) -run postman start

sh2:
	erl -sname $@ -setcookie $(COOKIE) -remsh sh1@$(HOSTNAME)

%.beam: %.erl
	erlc $<

etop:
	$(shell find /opt/erlang -type f -name etop | head -n1) -setcookie $(COOKIE) -node sh1@$(HOSTNAME)

clean:
	rm *.beam *.dump

.PHONY: all sh1 sh2 etop clean
