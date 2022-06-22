import Jetson.GPIO as GPIO
import time
import os

# 1 is still running, 0 is finished
program_status = 1

GPIO.setmode(GPIO.BOARD)

def handler_on(channel):
    print('on!')
    print('back up...')

    stream_status = os.popen("curl -s --head --connect-timeout 1 -i -X OPTIONS admin:nonia8123\!@192.168.18.100:554/profile1/media.sm; echo $?").read()

    if stream_status != 8:
        kogas_ds_alive = os.popen("pgrep kogas_ds.sh").read()
        deepstream_alive = os.popen("pgrep deepstream-app").read()

        if len(kogas_ds_alive) != 0:
            print("End deepstream ")
            os.system("killall -s SIGUSR1 kogas_ds.sh")
            os.system("killall -s SIGINT deepstream-app")
        global program_status
        program_status = 0
        print(program_status)

GPIO.setup(32, GPIO.IN)

GPIO.add_event_detect(32,GPIO.RISING, callback=handler_on)

try:
    while program_status:
        time.sleep(2)
        print(GPIO.input(32))

except KeyboardInterrupt:
    pass

finally:
    print("END")
    GPIO.cleanup()
