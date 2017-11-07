5. block本质是什么？


底层实现

block是一个指针结构体，在终端下通过clang -rewrite-objc 指令看看C++代码。

创建一个OS X 工程，写一个最简单的block

利用终端编译生成C++代码：
clang -rewrite-objc main.m

几个重要的结构体和函数简介：
__block_impl：这是一个结构体，也是C面向对象的体现，可以理解为block的基类;
__main_block_impl_0: 可以理解为block变量;
__main_block_func_0: 可以理解为匿名函数；
__main_block_desc_0:block的描述, Block_size;
__main_block_desc_0:block的描述, Block_size;
1、__block_impl

struct __block_impl {
  void *isa;
  int Flags;
  int Reserved;
  void *FuncPtr;
};

2、__main_block_impl_0

struct __main_block_impl_0 {
  struct __block_impl impl;
  struct __main_block_desc_0* Desc;
  __main_block_impl_0(void *fp,
 struct __main_block_desc_0 *desc, int flags=0) {
    impl.isa = &_NSConcreteStackBlock;
    impl.Flags = flags;
    impl.FuncPtr = fp;
    Desc = desc;
  }
};

3、__main_block_func_0

static void __main_block_func_0
 (struct __main_block_impl_0 *__cself) {
            NSLog((NSString *)
 &__NSConstantStringImpl__var_folders_gc_
 5fkhcz0n6px48vzc744hmp6c0000gn_T_main_eef954_mi_0);
        }

4、 __main_block_desc_0

staticstruct __main_block_desc_0 {
  size_t reserved;
  size_t Block_size;
} __main_block_desc_0_DATA =
  { 0, sizeof(struct __main_block_impl_0)};

int main(int argc, const char * argv[]) {
    /* @autoreleasepool */
   { __AtAutoreleasePool __autoreleasepool;
        void (*myblock)() = ((void (*)
   ())&__main_block_impl_0((void *)__main_block_func_0, 
   &__main_block_desc_0_DATA));
        ((void (*)(__block_impl *))
   ((__block_impl *)myblock)->FuncPtr)((__block_impl *)myblock);
    }
    return 0;
}
注意事项：block容易造成循环引用，在block里面如果使用了self，
然后形成强引用时，需要打断循环引用
在MRC下用_block，在ARC下使用__weak;

关于block在内存中的位置
深入理解
block快的存储位置（block入口的地址）可能存放在3个地方：代码区（全局区）、堆区、栈区（ARC情况下回自动拷贝到堆区、因此ARC下只有两个地方：代码区和堆区）。
    •    
    •    代码区：不访问栈区的变量（如局部变量），且不访问堆区的变量（如用alloc创建的对象）时，此时block存放在代码区；
    •    堆区：如果访问了堆区的变量（如局部变量），或堆区的变量（如用alloc创建的对象），此时block存方在堆区；--需要注意
    ◦    实际是放在栈区，在ARC情况下自动拷贝到堆区，如果不是ARC则存放在栈区，所在函数执行完毕就回释放，想再外面调用需要用copy指向它，这样就拷贝到了堆区，strong属性不会拷贝、会造成野指针错区。（需要理解ARC是一种编译器特性，即编译器在编译时在核实的地方插入retain、release、autorelease，而不是iOS的运行时特性）。
    ◦    此外代码存在堆区时,需要注意，因为堆区不像代码区不变化，堆区是动态的（不断的创建销毁），当没有强指针指向的时候就会被销毁，如果再去访问这段代码时，程序就会崩溃！所以此种情况在定义block属性时需要指定为strong or copy。block是一段代码，即不可变，所以使用copy也不会深拷贝。