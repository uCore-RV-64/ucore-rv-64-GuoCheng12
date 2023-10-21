
build/kernel:     file format elf64-littleriscv


Disassembly of section .text:

0000000080200000 <_entry>:
    .section .text.entry
    .globl _entry
_entry:
    la sp, boot_stack_top
    80200000:	00012117          	auipc	sp,0x12
    80200004:	00010113          	mv	sp,sp
    call main
    80200008:	06a000ef          	jal	ra,80200072 <main>

000000008020000c <consputc>:
#include "console.h"
#include "sbi.h"

void consputc(int c)
{
    8020000c:	1141                	addi	sp,sp,-16
    8020000e:	e406                	sd	ra,8(sp)
    80200010:	e022                	sd	s0,0(sp)
    80200012:	0800                	addi	s0,sp,16
	console_putchar(c);
    80200014:	00000097          	auipc	ra,0x0
    80200018:	1fa080e7          	jalr	506(ra) # 8020020e <console_putchar>
}
    8020001c:	60a2                	ld	ra,8(sp)
    8020001e:	6402                	ld	s0,0(sp)
    80200020:	0141                	addi	sp,sp,16
    80200022:	8082                	ret

0000000080200024 <console_init>:

void console_init()
{
    80200024:	1141                	addi	sp,sp,-16
    80200026:	e422                	sd	s0,8(sp)
    80200028:	0800                	addi	s0,sp,16
	// DO NOTHING
    8020002a:	6422                	ld	s0,8(sp)
    8020002c:	0141                	addi	sp,sp,16
    8020002e:	8082                	ret

0000000080200030 <threadid>:
extern char e_data[];
extern char s_bss[];
extern char e_bss[];

int threadid()
{
    80200030:	1141                	addi	sp,sp,-16
    80200032:	e422                	sd	s0,8(sp)
    80200034:	0800                	addi	s0,sp,16
	return 0;
}
    80200036:	4501                	li	a0,0
    80200038:	6422                	ld	s0,8(sp)
    8020003a:	0141                	addi	sp,sp,16
    8020003c:	8082                	ret

000000008020003e <clean_bss>:

void clean_bss()
{
    8020003e:	1141                	addi	sp,sp,-16
    80200040:	e422                	sd	s0,8(sp)
    80200042:	0800                	addi	s0,sp,16
	char *p;
	for (p = s_bss; p < e_bss; ++p)
    80200044:	00012717          	auipc	a4,0x12
    80200048:	fbc70713          	addi	a4,a4,-68 # 80212000 <boot_stack_top>
    8020004c:	00012797          	auipc	a5,0x12
    80200050:	fb478793          	addi	a5,a5,-76 # 80212000 <boot_stack_top>
    80200054:	00f77c63          	bgeu	a4,a5,8020006c <clean_bss+0x2e>
    80200058:	87ba                	mv	a5,a4
    8020005a:	00012717          	auipc	a4,0x12
    8020005e:	fa670713          	addi	a4,a4,-90 # 80212000 <boot_stack_top>
		*p = 0;
    80200062:	00078023          	sb	zero,0(a5)
	for (p = s_bss; p < e_bss; ++p)
    80200066:	0785                	addi	a5,a5,1
    80200068:	fee79de3          	bne	a5,a4,80200062 <clean_bss+0x24>
}
    8020006c:	6422                	ld	s0,8(sp)
    8020006e:	0141                	addi	sp,sp,16
    80200070:	8082                	ret

0000000080200072 <main>:

void main()
{
    80200072:	1141                	addi	sp,sp,-16
    80200074:	e406                	sd	ra,8(sp)
    80200076:	e022                	sd	s0,0(sp)
    80200078:	0800                	addi	s0,sp,16
	clean_bss();
    8020007a:	00000097          	auipc	ra,0x0
    8020007e:	fc4080e7          	jalr	-60(ra) # 8020003e <clean_bss>
	console_init();
    80200082:	00000097          	auipc	ra,0x0
    80200086:	fa2080e7          	jalr	-94(ra) # 80200024 <console_init>
	printf("\n");
    8020008a:	00001517          	auipc	a0,0x1
    8020008e:	0de50513          	addi	a0,a0,222 # 80201168 <e_text+0x168>
    80200092:	00000097          	auipc	ra,0x0
    80200096:	266080e7          	jalr	614(ra) # 802002f8 <printf>
	printf("hello wrold!\n");
    8020009a:	00001517          	auipc	a0,0x1
    8020009e:	f6650513          	addi	a0,a0,-154 # 80201000 <e_text>
    802000a2:	00000097          	auipc	ra,0x0
    802000a6:	256080e7          	jalr	598(ra) # 802002f8 <printf>
	errorf("stext: %p", s_text);
    802000aa:	00000717          	auipc	a4,0x0
    802000ae:	f5670713          	addi	a4,a4,-170 # 80200000 <_entry>
    802000b2:	4681                	li	a3,0
    802000b4:	00001617          	auipc	a2,0x1
    802000b8:	f5c60613          	addi	a2,a2,-164 # 80201010 <e_text+0x10>
    802000bc:	45fd                	li	a1,31
    802000be:	00001517          	auipc	a0,0x1
    802000c2:	f5a50513          	addi	a0,a0,-166 # 80201018 <e_text+0x18>
    802000c6:	00000097          	auipc	ra,0x0
    802000ca:	232080e7          	jalr	562(ra) # 802002f8 <printf>
	warnf("etext: %p", e_text);
    802000ce:	00001717          	auipc	a4,0x1
    802000d2:	f3270713          	addi	a4,a4,-206 # 80201000 <e_text>
    802000d6:	4681                	li	a3,0
    802000d8:	00001617          	auipc	a2,0x1
    802000dc:	f6060613          	addi	a2,a2,-160 # 80201038 <e_text+0x38>
    802000e0:	05d00593          	li	a1,93
    802000e4:	00001517          	auipc	a0,0x1
    802000e8:	f5c50513          	addi	a0,a0,-164 # 80201040 <e_text+0x40>
    802000ec:	00000097          	auipc	ra,0x0
    802000f0:	20c080e7          	jalr	524(ra) # 802002f8 <printf>
	infof("sroda: %p", s_rodata);
    802000f4:	00001717          	auipc	a4,0x1
    802000f8:	f0c70713          	addi	a4,a4,-244 # 80201000 <e_text>
    802000fc:	4681                	li	a3,0
    802000fe:	00001617          	auipc	a2,0x1
    80200102:	f6260613          	addi	a2,a2,-158 # 80201060 <e_text+0x60>
    80200106:	02200593          	li	a1,34
    8020010a:	00001517          	auipc	a0,0x1
    8020010e:	f5e50513          	addi	a0,a0,-162 # 80201068 <e_text+0x68>
    80200112:	00000097          	auipc	ra,0x0
    80200116:	1e6080e7          	jalr	486(ra) # 802002f8 <printf>
	debugf("eroda: %p", e_rodata);
    8020011a:	00002717          	auipc	a4,0x2
    8020011e:	ee670713          	addi	a4,a4,-282 # 80202000 <boot_stack>
    80200122:	4681                	li	a3,0
    80200124:	00001617          	auipc	a2,0x1
    80200128:	f6460613          	addi	a2,a2,-156 # 80201088 <e_text+0x88>
    8020012c:	02000593          	li	a1,32
    80200130:	00001517          	auipc	a0,0x1
    80200134:	f6050513          	addi	a0,a0,-160 # 80201090 <e_text+0x90>
    80200138:	00000097          	auipc	ra,0x0
    8020013c:	1c0080e7          	jalr	448(ra) # 802002f8 <printf>
	debugf("sdata: %p", s_data);
    80200140:	00002717          	auipc	a4,0x2
    80200144:	ec070713          	addi	a4,a4,-320 # 80202000 <boot_stack>
    80200148:	4681                	li	a3,0
    8020014a:	00001617          	auipc	a2,0x1
    8020014e:	f3e60613          	addi	a2,a2,-194 # 80201088 <e_text+0x88>
    80200152:	02000593          	li	a1,32
    80200156:	00001517          	auipc	a0,0x1
    8020015a:	f5a50513          	addi	a0,a0,-166 # 802010b0 <e_text+0xb0>
    8020015e:	00000097          	auipc	ra,0x0
    80200162:	19a080e7          	jalr	410(ra) # 802002f8 <printf>
	infof("edata: %p", e_data);
    80200166:	00002717          	auipc	a4,0x2
    8020016a:	e9a70713          	addi	a4,a4,-358 # 80202000 <boot_stack>
    8020016e:	4681                	li	a3,0
    80200170:	00001617          	auipc	a2,0x1
    80200174:	ef060613          	addi	a2,a2,-272 # 80201060 <e_text+0x60>
    80200178:	02200593          	li	a1,34
    8020017c:	00001517          	auipc	a0,0x1
    80200180:	f5450513          	addi	a0,a0,-172 # 802010d0 <e_text+0xd0>
    80200184:	00000097          	auipc	ra,0x0
    80200188:	174080e7          	jalr	372(ra) # 802002f8 <printf>
	warnf("sbss : %p", s_bss);
    8020018c:	00012717          	auipc	a4,0x12
    80200190:	e7470713          	addi	a4,a4,-396 # 80212000 <boot_stack_top>
    80200194:	4681                	li	a3,0
    80200196:	00001617          	auipc	a2,0x1
    8020019a:	ea260613          	addi	a2,a2,-350 # 80201038 <e_text+0x38>
    8020019e:	05d00593          	li	a1,93
    802001a2:	00001517          	auipc	a0,0x1
    802001a6:	f4e50513          	addi	a0,a0,-178 # 802010f0 <e_text+0xf0>
    802001aa:	00000097          	auipc	ra,0x0
    802001ae:	14e080e7          	jalr	334(ra) # 802002f8 <printf>
	errorf("ebss : %p", e_bss);
    802001b2:	00012717          	auipc	a4,0x12
    802001b6:	e4e70713          	addi	a4,a4,-434 # 80212000 <boot_stack_top>
    802001ba:	4681                	li	a3,0
    802001bc:	00001617          	auipc	a2,0x1
    802001c0:	e5460613          	addi	a2,a2,-428 # 80201010 <e_text+0x10>
    802001c4:	45fd                	li	a1,31
    802001c6:	00001517          	auipc	a0,0x1
    802001ca:	f4a50513          	addi	a0,a0,-182 # 80201110 <e_text+0x110>
    802001ce:	00000097          	auipc	ra,0x0
    802001d2:	12a080e7          	jalr	298(ra) # 802002f8 <printf>
	panic("ALL DONE");
    802001d6:	02700793          	li	a5,39
    802001da:	00001717          	auipc	a4,0x1
    802001de:	f5670713          	addi	a4,a4,-170 # 80201130 <e_text+0x130>
    802001e2:	4681                	li	a3,0
    802001e4:	00001617          	auipc	a2,0x1
    802001e8:	f5c60613          	addi	a2,a2,-164 # 80201140 <e_text+0x140>
    802001ec:	45fd                	li	a1,31
    802001ee:	00001517          	auipc	a0,0x1
    802001f2:	f5a50513          	addi	a0,a0,-166 # 80201148 <e_text+0x148>
    802001f6:	00000097          	auipc	ra,0x0
    802001fa:	102080e7          	jalr	258(ra) # 802002f8 <printf>
    802001fe:	00000097          	auipc	ra,0x0
    80200202:	040080e7          	jalr	64(ra) # 8020023e <shutdown>
}
    80200206:	60a2                	ld	ra,8(sp)
    80200208:	6402                	ld	s0,0(sp)
    8020020a:	0141                	addi	sp,sp,16
    8020020c:	8082                	ret

000000008020020e <console_putchar>:
		     : "memory");
	return a0;
}

void console_putchar(int c)
{
    8020020e:	1141                	addi	sp,sp,-16
    80200210:	e422                	sd	s0,8(sp)
    80200212:	0800                	addi	s0,sp,16
	register uint64 a1 asm("a1") = arg1;
    80200214:	4581                	li	a1,0
	register uint64 a2 asm("a2") = arg2;
    80200216:	4601                	li	a2,0
	register uint64 a7 asm("a7") = which;
    80200218:	4885                	li	a7,1
	asm volatile("ecall"
    8020021a:	00000073          	ecall
	sbi_call(SBI_CONSOLE_PUTCHAR, c, 0, 0);
}
    8020021e:	6422                	ld	s0,8(sp)
    80200220:	0141                	addi	sp,sp,16
    80200222:	8082                	ret

0000000080200224 <console_getchar>:

int console_getchar()
{
    80200224:	1141                	addi	sp,sp,-16
    80200226:	e422                	sd	s0,8(sp)
    80200228:	0800                	addi	s0,sp,16
	register uint64 a0 asm("a0") = arg0;
    8020022a:	4501                	li	a0,0
	register uint64 a1 asm("a1") = arg1;
    8020022c:	4581                	li	a1,0
	register uint64 a2 asm("a2") = arg2;
    8020022e:	4601                	li	a2,0
	register uint64 a7 asm("a7") = which;
    80200230:	4889                	li	a7,2
	asm volatile("ecall"
    80200232:	00000073          	ecall
	return sbi_call(SBI_CONSOLE_GETCHAR, 0, 0, 0);
}
    80200236:	2501                	sext.w	a0,a0
    80200238:	6422                	ld	s0,8(sp)
    8020023a:	0141                	addi	sp,sp,16
    8020023c:	8082                	ret

000000008020023e <shutdown>:

void shutdown()
{
    8020023e:	1141                	addi	sp,sp,-16
    80200240:	e422                	sd	s0,8(sp)
    80200242:	0800                	addi	s0,sp,16
	register uint64 a0 asm("a0") = arg0;
    80200244:	4501                	li	a0,0
	register uint64 a1 asm("a1") = arg1;
    80200246:	4581                	li	a1,0
	register uint64 a2 asm("a2") = arg2;
    80200248:	4601                	li	a2,0
	register uint64 a7 asm("a7") = which;
    8020024a:	48a1                	li	a7,8
	asm volatile("ecall"
    8020024c:	00000073          	ecall
	sbi_call(SBI_SHUTDOWN, 0, 0, 0);
    80200250:	6422                	ld	s0,8(sp)
    80200252:	0141                	addi	sp,sp,16
    80200254:	8082                	ret

0000000080200256 <printint>:
#include "console.h"
#include "defs.h"
static char digits[] = "0123456789abcdef";

static void printint(int xx, int base, int sign)
{
    80200256:	7179                	addi	sp,sp,-48
    80200258:	f406                	sd	ra,40(sp)
    8020025a:	f022                	sd	s0,32(sp)
    8020025c:	ec26                	sd	s1,24(sp)
    8020025e:	e84a                	sd	s2,16(sp)
    80200260:	1800                	addi	s0,sp,48
	char buf[16];
	int i;
	uint x;

	if (sign && (sign = xx < 0))
    80200262:	c219                	beqz	a2,80200268 <printint+0x12>
    80200264:	08054663          	bltz	a0,802002f0 <printint+0x9a>
		x = -xx;
	else
		x = xx;
    80200268:	2501                	sext.w	a0,a0
    8020026a:	4881                	li	a7,0
    8020026c:	fd040693          	addi	a3,s0,-48

	i = 0;
    80200270:	4701                	li	a4,0
	do {
		buf[i++] = digits[x % base];
    80200272:	2581                	sext.w	a1,a1
    80200274:	00001617          	auipc	a2,0x1
    80200278:	f3c60613          	addi	a2,a2,-196 # 802011b0 <digits>
    8020027c:	883a                	mv	a6,a4
    8020027e:	2705                	addiw	a4,a4,1
    80200280:	02b577bb          	remuw	a5,a0,a1
    80200284:	1782                	slli	a5,a5,0x20
    80200286:	9381                	srli	a5,a5,0x20
    80200288:	97b2                	add	a5,a5,a2
    8020028a:	0007c783          	lbu	a5,0(a5)
    8020028e:	00f68023          	sb	a5,0(a3)
	} while ((x /= base) != 0);
    80200292:	0005079b          	sext.w	a5,a0
    80200296:	02b5553b          	divuw	a0,a0,a1
    8020029a:	0685                	addi	a3,a3,1
    8020029c:	feb7f0e3          	bgeu	a5,a1,8020027c <printint+0x26>

	if (sign)
    802002a0:	00088b63          	beqz	a7,802002b6 <printint+0x60>
		buf[i++] = '-';
    802002a4:	fe040793          	addi	a5,s0,-32
    802002a8:	973e                	add	a4,a4,a5
    802002aa:	02d00793          	li	a5,45
    802002ae:	fef70823          	sb	a5,-16(a4)
    802002b2:	0028071b          	addiw	a4,a6,2

	while (--i >= 0)
    802002b6:	02e05763          	blez	a4,802002e4 <printint+0x8e>
    802002ba:	fd040793          	addi	a5,s0,-48
    802002be:	00e784b3          	add	s1,a5,a4
    802002c2:	fff78913          	addi	s2,a5,-1
    802002c6:	993a                	add	s2,s2,a4
    802002c8:	377d                	addiw	a4,a4,-1
    802002ca:	1702                	slli	a4,a4,0x20
    802002cc:	9301                	srli	a4,a4,0x20
    802002ce:	40e90933          	sub	s2,s2,a4
		consputc(buf[i]);
    802002d2:	fff4c503          	lbu	a0,-1(s1)
    802002d6:	00000097          	auipc	ra,0x0
    802002da:	d36080e7          	jalr	-714(ra) # 8020000c <consputc>
	while (--i >= 0)
    802002de:	14fd                	addi	s1,s1,-1
    802002e0:	ff2499e3          	bne	s1,s2,802002d2 <printint+0x7c>
}
    802002e4:	70a2                	ld	ra,40(sp)
    802002e6:	7402                	ld	s0,32(sp)
    802002e8:	64e2                	ld	s1,24(sp)
    802002ea:	6942                	ld	s2,16(sp)
    802002ec:	6145                	addi	sp,sp,48
    802002ee:	8082                	ret
		x = -xx;
    802002f0:	40a0053b          	negw	a0,a0
	if (sign && (sign = xx < 0))
    802002f4:	4885                	li	a7,1
		x = -xx;
    802002f6:	bf9d                	j	8020026c <printint+0x16>

00000000802002f8 <printf>:
		consputc(digits[x >> (sizeof(uint64) * 8 - 4)]);
}

// Print to the console. only understands %d, %x, %p, %s.
void printf(char *fmt, ...)
{
    802002f8:	7131                	addi	sp,sp,-192
    802002fa:	fc86                	sd	ra,120(sp)
    802002fc:	f8a2                	sd	s0,112(sp)
    802002fe:	f4a6                	sd	s1,104(sp)
    80200300:	f0ca                	sd	s2,96(sp)
    80200302:	ecce                	sd	s3,88(sp)
    80200304:	e8d2                	sd	s4,80(sp)
    80200306:	e4d6                	sd	s5,72(sp)
    80200308:	e0da                	sd	s6,64(sp)
    8020030a:	fc5e                	sd	s7,56(sp)
    8020030c:	f862                	sd	s8,48(sp)
    8020030e:	f466                	sd	s9,40(sp)
    80200310:	f06a                	sd	s10,32(sp)
    80200312:	ec6e                	sd	s11,24(sp)
    80200314:	0100                	addi	s0,sp,128
    80200316:	8a2a                	mv	s4,a0
    80200318:	e40c                	sd	a1,8(s0)
    8020031a:	e810                	sd	a2,16(s0)
    8020031c:	ec14                	sd	a3,24(s0)
    8020031e:	f018                	sd	a4,32(s0)
    80200320:	f41c                	sd	a5,40(s0)
    80200322:	03043823          	sd	a6,48(s0)
    80200326:	03143c23          	sd	a7,56(s0)
	va_list ap;
	int i, c;
	char *s;

	if (fmt == 0)
    8020032a:	c915                	beqz	a0,8020035e <printf+0x66>
		panic("null fmt");

	va_start(ap, fmt);
    8020032c:	00840793          	addi	a5,s0,8
    80200330:	f8f43423          	sd	a5,-120(s0)
	for (i = 0; (c = fmt[i] & 0xff) != 0; i++) {
    80200334:	000a4503          	lbu	a0,0(s4)
    80200338:	16050c63          	beqz	a0,802004b0 <printf+0x1b8>
    8020033c:	4981                	li	s3,0
		if (c != '%') {
    8020033e:	02500a93          	li	s5,37
			continue;
		}
		c = fmt[++i] & 0xff;
		if (c == 0)
			break;
		switch (c) {
    80200342:	07000b93          	li	s7,112
	consputc('x');
    80200346:	4d41                	li	s10,16
		consputc(digits[x >> (sizeof(uint64) * 8 - 4)]);
    80200348:	00001b17          	auipc	s6,0x1
    8020034c:	e68b0b13          	addi	s6,s6,-408 # 802011b0 <digits>
		switch (c) {
    80200350:	07300c93          	li	s9,115
			printptr(va_arg(ap, uint64));
			break;
		case 's':
			if ((s = va_arg(ap, char *)) == 0)
				s = "(null)";
			for (; *s; s++)
    80200354:	02800d93          	li	s11,40
		switch (c) {
    80200358:	06400c13          	li	s8,100
    8020035c:	a889                	j	802003ae <printf+0xb6>
		panic("null fmt");
    8020035e:	00000097          	auipc	ra,0x0
    80200362:	cd2080e7          	jalr	-814(ra) # 80200030 <threadid>
    80200366:	86aa                	mv	a3,a0
    80200368:	02e00793          	li	a5,46
    8020036c:	00001717          	auipc	a4,0x1
    80200370:	e0c70713          	addi	a4,a4,-500 # 80201178 <e_text+0x178>
    80200374:	00001617          	auipc	a2,0x1
    80200378:	dcc60613          	addi	a2,a2,-564 # 80201140 <e_text+0x140>
    8020037c:	45fd                	li	a1,31
    8020037e:	00001517          	auipc	a0,0x1
    80200382:	e0a50513          	addi	a0,a0,-502 # 80201188 <e_text+0x188>
    80200386:	00000097          	auipc	ra,0x0
    8020038a:	f72080e7          	jalr	-142(ra) # 802002f8 <printf>
    8020038e:	00000097          	auipc	ra,0x0
    80200392:	eb0080e7          	jalr	-336(ra) # 8020023e <shutdown>
    80200396:	bf59                	j	8020032c <printf+0x34>
			consputc(c);
    80200398:	00000097          	auipc	ra,0x0
    8020039c:	c74080e7          	jalr	-908(ra) # 8020000c <consputc>
	for (i = 0; (c = fmt[i] & 0xff) != 0; i++) {
    802003a0:	2985                	addiw	s3,s3,1
    802003a2:	013a07b3          	add	a5,s4,s3
    802003a6:	0007c503          	lbu	a0,0(a5)
    802003aa:	10050363          	beqz	a0,802004b0 <printf+0x1b8>
		if (c != '%') {
    802003ae:	ff5515e3          	bne	a0,s5,80200398 <printf+0xa0>
		c = fmt[++i] & 0xff;
    802003b2:	2985                	addiw	s3,s3,1
    802003b4:	013a07b3          	add	a5,s4,s3
    802003b8:	0007c783          	lbu	a5,0(a5)
    802003bc:	0007849b          	sext.w	s1,a5
		if (c == 0)
    802003c0:	cbe5                	beqz	a5,802004b0 <printf+0x1b8>
		switch (c) {
    802003c2:	05778a63          	beq	a5,s7,80200416 <printf+0x11e>
    802003c6:	02fbf663          	bgeu	s7,a5,802003f2 <printf+0xfa>
    802003ca:	09978863          	beq	a5,s9,8020045a <printf+0x162>
    802003ce:	07800713          	li	a4,120
    802003d2:	0ce79463          	bne	a5,a4,8020049a <printf+0x1a2>
			printint(va_arg(ap, int), 16, 1);
    802003d6:	f8843783          	ld	a5,-120(s0)
    802003da:	00878713          	addi	a4,a5,8
    802003de:	f8e43423          	sd	a4,-120(s0)
    802003e2:	4605                	li	a2,1
    802003e4:	85ea                	mv	a1,s10
    802003e6:	4388                	lw	a0,0(a5)
    802003e8:	00000097          	auipc	ra,0x0
    802003ec:	e6e080e7          	jalr	-402(ra) # 80200256 <printint>
			break;
    802003f0:	bf45                	j	802003a0 <printf+0xa8>
		switch (c) {
    802003f2:	09578e63          	beq	a5,s5,8020048e <printf+0x196>
    802003f6:	0b879263          	bne	a5,s8,8020049a <printf+0x1a2>
			printint(va_arg(ap, int), 10, 1);
    802003fa:	f8843783          	ld	a5,-120(s0)
    802003fe:	00878713          	addi	a4,a5,8
    80200402:	f8e43423          	sd	a4,-120(s0)
    80200406:	4605                	li	a2,1
    80200408:	45a9                	li	a1,10
    8020040a:	4388                	lw	a0,0(a5)
    8020040c:	00000097          	auipc	ra,0x0
    80200410:	e4a080e7          	jalr	-438(ra) # 80200256 <printint>
			break;
    80200414:	b771                	j	802003a0 <printf+0xa8>
			printptr(va_arg(ap, uint64));
    80200416:	f8843783          	ld	a5,-120(s0)
    8020041a:	00878713          	addi	a4,a5,8
    8020041e:	f8e43423          	sd	a4,-120(s0)
    80200422:	0007b903          	ld	s2,0(a5)
	consputc('0');
    80200426:	03000513          	li	a0,48
    8020042a:	00000097          	auipc	ra,0x0
    8020042e:	be2080e7          	jalr	-1054(ra) # 8020000c <consputc>
	consputc('x');
    80200432:	07800513          	li	a0,120
    80200436:	00000097          	auipc	ra,0x0
    8020043a:	bd6080e7          	jalr	-1066(ra) # 8020000c <consputc>
    8020043e:	84ea                	mv	s1,s10
		consputc(digits[x >> (sizeof(uint64) * 8 - 4)]);
    80200440:	03c95793          	srli	a5,s2,0x3c
    80200444:	97da                	add	a5,a5,s6
    80200446:	0007c503          	lbu	a0,0(a5)
    8020044a:	00000097          	auipc	ra,0x0
    8020044e:	bc2080e7          	jalr	-1086(ra) # 8020000c <consputc>
	for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
    80200452:	0912                	slli	s2,s2,0x4
    80200454:	34fd                	addiw	s1,s1,-1
    80200456:	f4ed                	bnez	s1,80200440 <printf+0x148>
    80200458:	b7a1                	j	802003a0 <printf+0xa8>
			if ((s = va_arg(ap, char *)) == 0)
    8020045a:	f8843783          	ld	a5,-120(s0)
    8020045e:	00878713          	addi	a4,a5,8
    80200462:	f8e43423          	sd	a4,-120(s0)
    80200466:	6384                	ld	s1,0(a5)
    80200468:	cc89                	beqz	s1,80200482 <printf+0x18a>
			for (; *s; s++)
    8020046a:	0004c503          	lbu	a0,0(s1)
    8020046e:	d90d                	beqz	a0,802003a0 <printf+0xa8>
				consputc(*s);
    80200470:	00000097          	auipc	ra,0x0
    80200474:	b9c080e7          	jalr	-1124(ra) # 8020000c <consputc>
			for (; *s; s++)
    80200478:	0485                	addi	s1,s1,1
    8020047a:	0004c503          	lbu	a0,0(s1)
    8020047e:	f96d                	bnez	a0,80200470 <printf+0x178>
    80200480:	b705                	j	802003a0 <printf+0xa8>
				s = "(null)";
    80200482:	00001497          	auipc	s1,0x1
    80200486:	cee48493          	addi	s1,s1,-786 # 80201170 <e_text+0x170>
			for (; *s; s++)
    8020048a:	856e                	mv	a0,s11
    8020048c:	b7d5                	j	80200470 <printf+0x178>
			break;
		case '%':
			consputc('%');
    8020048e:	8556                	mv	a0,s5
    80200490:	00000097          	auipc	ra,0x0
    80200494:	b7c080e7          	jalr	-1156(ra) # 8020000c <consputc>
			break;
    80200498:	b721                	j	802003a0 <printf+0xa8>
		default:
			// Print unknown % sequence to draw attention.
			consputc('%');
    8020049a:	8556                	mv	a0,s5
    8020049c:	00000097          	auipc	ra,0x0
    802004a0:	b70080e7          	jalr	-1168(ra) # 8020000c <consputc>
			consputc(c);
    802004a4:	8526                	mv	a0,s1
    802004a6:	00000097          	auipc	ra,0x0
    802004aa:	b66080e7          	jalr	-1178(ra) # 8020000c <consputc>
			break;
    802004ae:	bdcd                	j	802003a0 <printf+0xa8>
		}
	}
    802004b0:	70e6                	ld	ra,120(sp)
    802004b2:	7446                	ld	s0,112(sp)
    802004b4:	74a6                	ld	s1,104(sp)
    802004b6:	7906                	ld	s2,96(sp)
    802004b8:	69e6                	ld	s3,88(sp)
    802004ba:	6a46                	ld	s4,80(sp)
    802004bc:	6aa6                	ld	s5,72(sp)
    802004be:	6b06                	ld	s6,64(sp)
    802004c0:	7be2                	ld	s7,56(sp)
    802004c2:	7c42                	ld	s8,48(sp)
    802004c4:	7ca2                	ld	s9,40(sp)
    802004c6:	7d02                	ld	s10,32(sp)
    802004c8:	6de2                	ld	s11,24(sp)
    802004ca:	6129                	addi	sp,sp,192
    802004cc:	8082                	ret
	...
