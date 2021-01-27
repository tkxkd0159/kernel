---
sort: 15
---
# KVM

## Architecture independent files of kvm
### virt/kvm
* ioapic.h
* ioapic.c
* iodev.h
* kvm_main.c
  
## Architecture dependent files
These are files like vmx.c for Intel's HVM support or svm.c for AMD's HVM support.

### arch/x86/kvm
* Kconfig
* Makefile
* i8259.c
* irq.c
* irq.h
* kvm_svm.h
* lapic.c
* lapic.h
* mmu.c
* mmu.h
* paging_tmpl.h
* segment_descriptor.h
* svm.c
* svm.h
* vmx.c
* vmx.h
* x86.c
* x86_emulate.c

### include/linux
* kvm.h
* kvm_host.h
* kvm_para.h
* kvm_x86_emulate.h

### include/asm-x86
* kvm.h
* kvm_host.h
* kvm_para.h
* kvm_x86_emulate.h
