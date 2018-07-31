/****************************************************************************
 * uvmdev_isr_if.svh
 ****************************************************************************/

typedef class uvmdev_irq_if;

/**
 * Class: uvmdev_isr_if
 * 
 * A class that implements this interface provides interrupt requests to
 * a set of client devices
 */
interface class uvmdev_isr_if;

	/**
	 * Function: set_irq_listener
	 * 
	 * Specifies the interrupt listener for a given interrupt request
	 * 
	 * Parameters:
	 * - int irq            - The IRQ as identified by the ISR
	 * - uvmdev_irq_if dev  - The device to send interrupts to
	 * - int dev_irq        - The ID for the interrupt as identified by the device
	 * 
	 * Returns:
	 *   void
	 */
	pure virtual function void set_irq_listener(
			int unsigned 	irq,
			uvmdev_irq_if 	irq_if,
			int unsigned 	dev_irq=0);

endclass


