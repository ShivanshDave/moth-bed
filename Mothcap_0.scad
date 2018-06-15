l = 10;
w = 4;
h = 4;
wr_l = 3;
wr_w = 2;
pr_h = 10;
t = 0.1;
w_disp = 2;
c_h = 0.5;
pos = 0 || 1;
module bed(length,width){
    cube([length, width, t], true);
    }
module wing(pos){
    if(wr_l < l-w_disp){
        if(pos == 1){
        translate([((l-wr_l)/2)-w_disp,((wr_w+w)/2),0]){
            bed(wr_l,wr_w);
            }
            }else if(pos == 0){
                translate([(((l-wr_l)/2)-w_disp),-((wr_w+w)/2),0]){
            bed(wr_l,wr_w);
            }
  }
 }
}
module holder_downer(){
    bed(l,w);
    wing(1);wing(0);
    rotate([90,0,0]){
        translate([-l/4,(-c_h/2)+t/2,(w/2)+t/2])bed(l-(w_disp+wr_l),c_h);
        translate([-l/4,(-c_h/2)+t/2,(-w/2)+t/2]) bed(l-(w_disp+wr_l),c_h);
        rotate([0,90,0]) translate([0,-(c_h-t)/2,(-l/2)+t/2]) bed(w,c_h);
        rotate([0,-90,0]) translate([0,-(c_h-t)/2,(-l/2)+t/2]) bed(w,c_h);
        translate([(wr_l+(w_disp/2)),-(c_h-t)/2,(w-t)/2])bed(w_disp,c_h);  
        translate([wr_l+(w_disp/2),-(c_h-t)/2,-(w-t)/2])bed(w_disp,c_h);
        rotate([0,90,0]) translate([(w+wr_w-(t))/2,-(c_h-t)/2,t/2]) bed(wr_w+t,c_h);
        translate([wr_l-t,0,0])rotate([0,90,0]) translate([(w+wr_w-(t))/2,-(c_h-t)/2,t/2]) bed(wr_w+t,c_h);
        rotate([0,90,0]) translate([-(w+wr_w+(t/8))/2,-(c_h-t)/2,t/2]) bed(wr_w,c_h);
        translate([(wr_l-t),0,0])rotate([0,90,0]) translate([-(w+wr_w-(t))/2,-(c_h-t)/2,t/2]) bed(wr_w+t,c_h);
        translate([wr_l/2,-(c_h-t)/2,(w/2)+wr_w]) bed(wr_l,c_h);
        translate([wr_l/2,-(c_h-t)/2,-((w/2)+wr_w)]) bed(wr_l,c_h);
    }}
holder_downer();