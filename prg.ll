; ModuleID = 'my cool prog'

define i32 @main(i32) {
main:
  br i1 false, label %left, label %right
  ret i32 234

left:                                             ; preds = %main
  ret i32 2

right:                                            ; preds = %main
  ret i32 466
}
