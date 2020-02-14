import psutil
import datetime

def totalmemory():
    mem=psutil.virtual_memory()
    print("Date => {}".format(datetime.datetime.now()))
    print("Total => {} GB".format(mem.total/1024/1024/1024))
    print("Availble => {} GB".format(mem.available/1024/1024/1024))
    print("Used => {} GB".format(mem.used/1024/1024/1024))
    print("Free => {} GB".format(mem.free/1024/1024/1024))

if __name__ == "__main__":
    totalmemory()