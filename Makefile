SRC_DIR :=	src
INC_DIR :=	include
OBJ_DIR :=	obj
LNK_DIR :=	link
BLD_DIR :=	build

CC	:=	msp430-elf-gcc
HX	:= 	hex430
FL 	:= 	MSP430Flasher
AS	:= 	AStyle

CFLAGS	:=	-I$(INC_DIR) -O2 -Wall -g -mcpu=MSP430
LDFLAGS	:=	-L$(LNK_DIR) -T$(LNK_DIR)/msp430g2553.ld -mcpu=MSP430 \
			-Wl,-Map,$(BLD_DIR)/main.map,--gc-sections

SRCS	:=	$(wildcard $(SRC_DIR)/*.c)
OBJS	:=	$(patsubst $(SRC_DIR)/%.c, $(OBJ_DIR)/%.o, $(SRCS))
TRGT	:=	$(BLD_DIR)/main.txt

.PHONY: all impact test format clean

all: $(TRGT)

impact: $(TRGT)
	@echo
	@$(FL) -n MSP430G2xx3 -w $< -v -z [RESET, VCC=3300] -g -j fast

$(TRGT): $(OBJS) | $(BLD_DIR)
	@echo
	$(CC) $(LDFLAGS) $^ -o $(BLD_DIR)/main.out
	@echo
	$(HX) --memwidth=8 --romwidth=8 --quiet --ti_txt --outfile $@ $(BLD_DIR)/main.out

$(BLD_DIR):
	@mkdir -p $@

$(OBJ_DIR)/%.o: $(SRC_DIR)/%.c | $(OBJ_DIR)
	@echo
	@$(CC) $(CFLAGS) -S $< -o $(OBJ_DIR)/$*.s
	$(CC) $(CFLAGS) -c $< -o $@

$(OBJ_DIR):
	@mkdir -p $@

test:
#	@$(MAKE) --directory=test

format:
	@echo
	@$(AS) --suffix=none --style=java --indent=spaces=4 \
	--indent-switches --break-blocks --pad-oper --pad-paren-in --pad-header \
	--align-pointer=name --convert-tabs --max-code-length=100 --recursive \
	--preserve-date --verbose --formatted --lineend=windows --mode=c *.c *.h

clean:
	@echo
	$(RM) --recursive $(OBJ_DIR)
	$(RM) --recursive $(BLD_DIR)
#   @$(MAKE) --directory=test clean
