; ModuleID = 'prg.bc'

define i32 @main() {
  %x1 = add i32 1, 2
  %x2 = add i32 3, 4
  %y = add i32 %x1, %x2
  ret i32 %y
}
