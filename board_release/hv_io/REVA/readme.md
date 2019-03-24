# Rework
* Latch global reset
  MCU_Latch to U8 connected to BMS_IMD_LATCH on U11 and PS_Latch on U10
Shutdown Circuit Input Switches
  Input Connectors for Shutdown Circuits were not added ot board: Issue was resolved by connecting 18 awg wire to the underside of the PTH on the jumper to the PTH on the dsub.
  New Pins as follows:
  Connector J4B:
  Pin 13: Inertia Switch +
  Pin 14: Inertia Switch -
  Pin 17: Master/E-Stop Switch +
  Pin 18: Master/ E-Stop Switch -
