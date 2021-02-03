---
sort: 2
---

# Debug

## 1. printk
kernel의 변수를 찍어보기 위해 사용

```c
printk(KERN_CRIT "Example : %lu", load);
```
### 1.1. printk log level
log level을 설정함으로써 원하는 log level의 printk 기록만 볼 수 있다.  
`dmesg`를 통해 확인가능  

```bash
cat /proc/sys/kernel/printk # 4 4 1 7

# /etc/sysctl.conf   -> change log level
kernel.printk = 4 4 1 7
```
4 : Current Console Log Level -> 이 값보다 log level 낮은(우선순위 높은) 메세지만 콘솔출력  
4 : Default Message Log Level -> printk 사용 시 별도의 log level 설정하지 않을 경우 default level  
1 : Minimum Console Log Level -> Console Log Level의 최소값
7 : Boot-time-default

Log level|Name|Meaning
:---: |:---:| ----
 0 | KERN_EMERG | Emergency messages, system is about to crash or is unstable
 1 | KERN_ALERT | Something bad happened and action must be taken immediately	
 2 | KERN_CRIT | A critical condition occurred like a serious hardware/software failure
 3 | KERN_ERR | An error condition, often used by drivers to indicate difficulties with the hardware
 4 | KERN_WARNING | A warning, meaning nothing serious by itself but might indicate problems
 5 | KERN_NOTICE | Nothing serious, but notably nevertheless. Often used to report security events.
 6 | KERN_INFO | Informational message e.g. startup information at driver initialization
 7 | KERN_DEBUG | Debug messages
 - | KERN_DEFAULT | Emergency messages, system is about to crash or is unstable

