I Have edited the code and Verified the read and write operations on the APB slave1 and Slave2 with respect to the pready and pslverr signals.
When the psel, penable and pwrite are high the pwdata is writing into the respective paddr of the APB Slave.
when the psel, penable are high and pwrite is low the data has been reading via prdata with respective paddr from the APB Slave.
when the paddr exceeds the locactions in the slave memory, the pslverr becoming high saying the error in transaction fails.
when the write data is unknown value xx pslverr becoming high saying that write transaction failed in APB.
These changes in the APB Slave1 and Slave2 are made 

The changes made in the Slave are corrected in the Top module.

made changes to slave that the memory becomes clear when presetn is applied

changes made in APB Master:
1) Added the Parameterization for the APB Master of 32bit and 64 bit .
2) Added Comments for better understanding of the code.
3) Pslverr interface with the ACCESS phase is asserted as it is not effecting the functionality.
4) No other logic or functionality is changed.

changes made in APB SLave:
1) Added the Parameterization for the APB Slave1 and APB Slave2 for 32bit and 64bit

changes made in APB Top:
1) Parameterized APB Protocol Top for 32 bit and 64 bit.

changes made in slave1 and slave2:
1)Edited mem[paddr] to mem[paddr[ADDR_WIDTH-2:0]] in 55 and 59th line, So that it wont effect the Slave 2 write and read operations.

changes made in APB master:
1)made Pwdata, paddr, penable, pwrite and apb_read_data_out as 0 when presetn is applied.

Changes made in RTL
1) Added Time scale to the RTL
2) Removed Unnessesary logic in APB_master which is effecting Coverage

Changes made in RTL:
1) Added Comments to the RTL
2) Modified FSM coding style in APB Master
3) No functionaltity or Logic is changed in RTL
