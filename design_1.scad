// Var in mm
l = 10;
w = 4;
h = 4;
wr_l = 0.3;
wr_w = 2;
pr_r = 0.1;
t = 0.1;

module bed(length,width){cube([l, w, t], true);}
module side(pos){rotate([90,0,0]){if(pos== 1){translate([0,(h/2),((w/-2))]){bed(l,h);}}else if(pos ==0){translate([0,(h/2),((w/2))]){bed(l,h);}}}}
module wing(pos){if(pos == 1){translate([0,h,w]){bed(wr_l,wr_w);}}else if(pos == 0){translate([0,-h,w]){bed(wr_l,wr_w);}}}
module proboscis_rest(pr_h)translate([(l/2),0,0]){
    rotate([90,90,90]){cylinder(pr_h,r1 = (t/2), r2 =(t/2), centre =false,$fn=100);}}

bed(l,w);
side(1);side(0);
wing(1);wing(0);
proboscis_rest(10);