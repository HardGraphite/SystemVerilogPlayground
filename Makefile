SV_FLAGS += -g2012 -Wall

BUILD_DIR ?= /tmp/svp-build

SRCS = $(wildcard code/*.sv)
VTBS = $(patsubst code/%.sv,${BUILD_DIR}/%_tb.sv,${SRCS})
VVPS = $(patsubst code/%.sv,${BUILD_DIR}/%.vvp,${SRCS})
VCDS = $(patsubst code/%.sv,${BUILD_DIR}/%.vcd,${SRCS})

all: ${VCDS}

${BUILD_DIR}:
	@[ -d "${BUILD_DIR}" ] || mkdir "${BUILD_DIR}"
	@echo mkdir ${BUILD_DIR}

${BUILD_DIR}/%_tb.sv: code/%.sv ${BUILD_DIR}
	tools/testbench_collector.py --dump-file="$(subst _tb.sv,.vcd,$@)" -o $@ $<

${BUILD_DIR}/%.vvp: ${BUILD_DIR}/%_tb.sv
	iverilog ${SV_FLAGS} -tvvp -o $@ $<

${BUILD_DIR}/%.vcd: ${BUILD_DIR}/%.vvp
	vvp $<

.PHONY: clean
clean:
	rm ${VTBS} ${VVPS} ${VCDS}

.PRECIOUS: ${VTBS} ${VVPS} ${VCDS}
