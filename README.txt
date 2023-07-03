OpenE902环境设置


1.解压缩Xuantie-900-gcc-elf-newlib-x86_64-V2.6.1.tar.gz

2.设置环境变量添加到~/.bash_profile或者~/.bashrc的最后
  # E902 chip setup
  export CODE_BASE_PATH=/home/abcd/opene902/E902_RTL_FACTORY
  export TOOL_EXTENSION=/home/abcd/Xuantie-900-gcc-elf-newlib-x86_64-V2.6.1/bin

  其中的abcd需要依据实际路径进行修改

3.重新退出登录，以便使得环境变量设置生效

4.执行测试
  cd opene902/smart_run
  make runcase CASE=hello_world SIM=vcs


