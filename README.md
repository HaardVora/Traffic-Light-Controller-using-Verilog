# 🚦 Traffic Light Controller using Verilog

A **Finite State Machine (FSM) based Traffic Light Controller** designed and implemented in **Verilog HDL**. The controller uses **one-hot state encoding** to control Red, Yellow, and Green traffic lights with programmable timing for each state.

## 📌 Project Overview

This project demonstrates the design of a sequential digital system using:

- Verilog HDL
- Finite State Machine (FSM)
- One-hot state encoding
- Sequential and combinational logic
- Clock-based timing
- Reset and enable control
- Simulation and waveform-based verification

The controller cycles through the following traffic light sequence:

**OFF → RED → YELLOW → GREEN → YELLOW → RED → ...**

The duration of each light is controlled using a clock-based timer.

---

## 🔄 FSM State Diagram

```text
             enable
               ↓
             ┌─────┐
             │ OFF │
             └──┬──┘
                │
                ▼
            ┌───────┐
            │  RED  │
            │ 50 clk│
            └───┬───┘
                │
                ▼
          ┌──────────┐
          │  YELLOW  │
          │ 10 clk   │
          └────┬─────┘
               │
               ▼
           ┌────────┐
           │ GREEN  │
           │ 30 clk │
           └────┬───┘
                │
                ▼
          ┌──────────┐
          │ YELLOW_2 │
          │ 10 clk   │
          └────┬─────┘
               │
               ▼
              RED
```

---

## 🧠 FSM States

The controller uses **one-hot encoding** with five states:

| State | Encoding | Light | Duration |
|---|---|---|---:|
| OFF | `00001` | None | Until enabled |
| RED | `00010` | 🔴 Red | 50 clock cycles |
| YELLOW | `00100` | 🟡 Yellow | 10 clock cycles |
| GREEN | `01000` | 🟢 Green | 30 clock cycles |
| YELLOW_2 | `10000` | 🟡 Yellow | 10 clock cycles |

After `YELLOW_2`, the controller returns to the `RED` state.

---

## ⚙️ Inputs

| Signal | Width | Description |
|---|---:|---|
| `clk` | 1 bit | System clock |
| `reset` | 1 bit | Resets the controller to OFF |
| `enable` | 1 bit | Enables/disables the traffic controller |

## 💡 Outputs

| Signal | Width | Description |
|---|---:|---|
| `r` | 1 bit | Red light control |
| `y` | 1 bit | Yellow light control |
| `g` | 1 bit | Green light control |
| `state_out` | 4 bits | State monitoring/debugging output |

> **Note:** `state_out` is assigned from the internal 5-bit one-hot state register. The current implementation therefore exposes only the lower 4 bits of the 5-bit state.

---

## 🏗️ Design
