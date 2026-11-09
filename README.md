# Verilog LED Sequencer

A configurable LED sequencer implemented in **Verilog HDL**. The design combines a parameterized counter with a 7-bit shift register to generate a back-and-forth, single-LED lighting pattern (similar to a *Knight Rider* effect).

The design was **developed and tested using Intel/Altera Quartus**, with **ModelSim used for functional simulation and waveform analysis**. This repository keeps the **RTL source code and its testbenches** as a lightweight reference. Quartus project files, synthesis outputs, and generated simulation files are intentionally excluded.

## Development and verification tools

- **Intel/Altera Quartus:** RTL development, compilation, and design testing.
- **ModelSim:** Functional simulation of the Verilog modules using the included testbenches, with waveform inspection to verify their behavior.

## How it works

```text
             iCLK / iRST_n / iENABLE
                       |
                       v
                +--------------+
                | count_param  |
                |  counter     |
                +--------------+
                       | oTC (once per Cuenta cycles)
                       v
                +--------------+
          +---->|    shift7    |----> oPR[6:0]
          |     | shift register|          |
          |     +--------------+          v
          |             | oSR        +-----------+
          +---- NOT <---+            |  lights   |----> oLED[7:0]
                                     |  decoder  |
                                     +-----------+
```

- **`count_param`** generates a terminal-count pulse that controls the speed of the sequence.
- **`shift7`** advances its register when enabled. Its serial input is the inverse of its serial output, creating a repeating sequence of ones and zeros.
- **`lights`** maps the shift-register states to an 8-bit, one-hot LED output, moving the active LED in both directions.

## Repository structure

```text
Verilog-LED-Sequencer/
├── rtl/
│   ├── count_param.v   # Parameterized up/down counter
│   ├── shift7.v        # Parameterized shift register (7 bits by default)
│   └── lights.v        # Top-level LED sequencer
├── tb/
│   ├── tb_count.v      # Counter testbench
│   ├── tb_shift7.v     # Shift register testbench
│   └── tb_lights.v     # Integrated LED sequencer testbench
└── README.md
```

## Top-level interface

The top-level module is **`lights`**.

| Signal | Direction | Description |
| --- | --- | --- |
| `iCLK` | Input | System clock. |
| `iRST_n` | Input | Active-low, synchronous reset. |
| `iENABLE` | Input | Enables the counter and therefore sequence progression. |
| `oLED[7:0]` | Output | Eight LED control bits; normally one LED is active at a time. |

### Parameter

| Parameter | Default | Description |
| --- | --- | --- |
| `Cuenta` | `12500000` | Counter period, in input clock cycles, between shifts of the LED pattern. |

The LED step rate is approximately `fCLK / Cuenta` while the design is enabled. For faster simulation, `tb_lights.v` overrides `Cuenta` with `10`.

## Testbenches

The included testbenches provide input stimulus for:

| Testbench | Scenarios |
| --- | --- |
| `tb_count.v` | Up-counting, down-counting, synchronous reset, and enable behavior. |
| `tb_shift7.v` | Serial shifting, synchronous reset, and enable behavior. |
| `tb_lights.v` | LED sequence, synchronous reset, and enable behavior. |

These are **stimulus-based testbenches**: they use simulation messages and are intended for waveform inspection, rather than automatic pass/fail assertions.

## Simulation

The original design was simulated using **ModelSim**. The testbenches can also be run with other simulators that support the required Verilog constructs.

Use any simulator that supports the Verilog constructs used in the design (including `$clog2`). For example, with **Icarus Verilog**, run the following from the repository root:

```bash
iverilog -g2012 -s tb_lights -o sim_lights.vvp \
    rtl/count_param.v rtl/shift7.v rtl/lights.v tb/tb_lights.v
vvp -n sim_lights.vvp
```

To simulate the other modules individually, change the selected top-level testbench and included files:

```bash
# Counter
iverilog -g2012 -s tb_count -o sim_count.vvp rtl/count_param.v tb/tb_count.v
vvp -n sim_count.vvp

# Shift register
iverilog -g2012 -s tb_shift7 -o sim_shift7.vvp rtl/shift7.v tb/tb_shift7.v
vvp -n sim_shift7.vvp
```

**Note:** The original `count_param.v` in the supplied archive has an unclosed header comment (`/*` without `*/`). Add the closing `*/` before `module count_param` before compiling the counter or integrated design. This repository documentation does not otherwise alter the original RTL.

## Scope

The repository is intended as a **personal HDL reference and source-code backup**, not as a complete board-specific Quartus project. FPGA pin assignments, timing constraints, compiled bitstreams, and tool-generated files are not included.

## Maintainer

[majs1992J29](https://github.com/majs1992J29)

Original author attributions, where present, remain in the source files.
