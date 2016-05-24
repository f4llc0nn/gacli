GA=libpam-google-authenticator
GA_OBJS=hmac.o sha1.o base32.o pam_google_authenticator.o
OBJS=verf.o codegen.o cfgfile.o

.SUFFIXES:

.SUFFIXES: .o .c .h

.c.o :
	$(CC) -c -std=gnu99 $< 

hmac.o: $(GA)/hmac.c
	$(CC) -c -std=gnu99 $<

sha1.o: $(GA)/sha1.c
	$(CC) -c -std=gnu99 $<

base32.o: $(GA)/base32.c
	$(CC) -c -std=gnu99 $<

pam_google_authenticator.o: $(GA)/pam_google_authenticator.c
	$(CC) -c -std=gnu99 -DTESTING $<

gacli.o: gacli.c 
	$(CC) -c -std=gnu99 $<

bin/gacli: $(GA_OBJS) $(OBJS) gacli.o
	@mkdir -p $(@D)
	$(CC) -o $@ $^
	$(STRIP) $@

gacli: bin/gacli
	@true

all: gacli

clean:
	rm -rf bin
	rm *.o
