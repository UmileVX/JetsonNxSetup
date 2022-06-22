kogas_ds

xterm -e "cd /opt/nvidia/deepstream/deepstream-6.0/sources/objectDetector_Yolo/; ./kogas_ds.sh"

kogas startup



interrupt

xterm -e "cd ~; python3 interrupt.py"

kogas interrupt

xterm -e "cd ~; python3 interrupt.py"



LOG
add at end
" 2>&1 | tee ~/log.txt"


xterm -e "cd ~; python3 -u interrupt.py 2>&1 | tee ~/interrupt_log.txt"

xterm -e "cd /opt/nvidia/deepstream/deepstream-6.0/sources/objectDetector_Yolo/; ./kogas_ds.sh 2>&1 | tee ~/log.txt"

