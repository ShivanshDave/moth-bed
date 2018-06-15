// Var in mm. ALL VARIABLES MUST BE POSITIVE!
l = 10.13; //Length of the main bed
w = 5.11; //Width of the main bed
H = 1.34; //Height of the main structure
wr_l = 4.13; //Length of the wing-rest
wr_w = 5.11; //Width of the wing-rest
pr_h = 12.3; //height of the proboscis rest
pr_w = 1.21;
t = 0.14; //Overall thickness. VERY IMPORTANT!
w_disp = 2.13; //displacement of the wingrests from the front of the main body
c_h = 4.1; //Overall height of the cap 
pos = 0 || 1; // Specifies whether the structure goes left or right. 0 is left; 1 is right. Or vice-versa.

module bed(length,width){
    cube([length, width, t], true);
    }

module side(pos){
    rotate([90,0,0]){
        if(pos== 1){
            translate([0,((H/2)-t/2),(w/-2)+t/2]){
                bed(l,H);
                }
                }else if(pos ==0){
                    translate([0,((H/2)-t/2),((w/2)-t/2)]){
                        bed(l,H);
   }
  }
 }
}

module wing(pos){
    if(wr_l < (l-w_disp)){
        if(pos == 1){
        translate([((l-wr_l)/2)-w_disp,((wr_w+w-t)/2),H-t]){
            bed(wr_l,wr_w);
            }
            }else if(pos == 0){
                translate([((l-wr_l)/2)-w_disp,-((w+wr_w-t)/2),H-t]){
                    bed(wr_l,wr_w);
   }
  }
 }
}
module cap_wing(pos){
    if(wr_l < l-w_disp){
        if(pos == 1){
        translate([((l-wr_l)/2)-w_disp,((wr_w+w)/2),0]){
            bed(wr_l,wr_w);
            }
            }else if(pos == 0){
                translate([((l-wr_l)/2)-w_disp,-((wr_w+w)/2),0]){
            bed(wr_l,wr_w);
            }
  }
 }
}
module proboscis_rest(){
    translate([(l+pr_h)/2,0,0]){
        rotate([0,180,0]) {
            bed(pr_h,pr_w);
}
 }
}
module endcap(){
    translate([(l/-2)+t/2,0,(H/2)-t/2]){
        rotate([0,90,0]){
            bed(H,w);
        }
    }
}
module useful_module(){
    bed(l,w);
    cap_wing(1); cap_wing(0);
    rotate([90,0,0]){
        union(){
            translate([-(wr_l+w_disp)/2,(-c_h/2)+t/2,(w+t)/2]){
            bed(l-(w_disp+wr_l),c_h);//back left lateral
            }
            translate([-(wr_l+w_disp)/2,-c_h/2+t/2,-(w-t)/2]){
                bed(l-(w_disp+wr_l),c_h);//back right lateral
            }
            rotate([0,90,0]) translate([0,-(c_h-t)/2,(-l/2)+t/2]){
                bed(w,c_h);//back horizontal
            }
//            rotate([0,-90,0])translate([0,-(c_h-t)/2,(-l/2)+t/2]){
//                bed(w,c_h);//front horizontal
//            }
            translate([(l/2-w_disp+(w_disp/2)),-(c_h-t)/2,(w-t)/2]){
                bed(w_disp,c_h);//front left lateral
            }  
            translate([l/2-w_disp+(w_disp/2),-(c_h-t)/2,-(w-t)/2]){
                bed(w_disp,c_h);//front right lateral
            }
            rotate([0,90,0]) translate([(w+wr_w-t)/2,-(c_h-t)/2,(l/2-wr_l-w_disp)+t/2]){
                bed(wr_w+t,c_h);//back right wingrest
            }
            rotate([0,90,0]) translate([(w+wr_w-t)/2,-(c_h-t)/2,(l/2-w_disp)-(t/2)]){
                bed(wr_w+t,c_h);//front right wingrest
            }
            rotate([0,90,0]) translate([-(w+wr_w+(t/8))/2,-(c_h-t)/2,(l/2-wr_l-w_disp)+t/2]){
                bed(wr_w,c_h); //back left wingrest
            }
            rotate([0,90,0])translate([-(w+wr_w-t)/2,-(c_h-t)/2,(l/2-w_disp)-t/2]){
                bed(wr_w+t,c_h);//front left wingrest
            }
            translate([(l+t)/2-2*w_disp,-(c_h-t)/2,(w/2)+wr_w-t/2]) {
                bed(wr_l,c_h);//left wingspanner
            }
            translate([(l+t)/2-2*w_disp,-(c_h-t)/2,-((w/2)+wr_w-t/2)]){
                bed(wr_l,c_h);//right wingspanner
            }
        }
    }
}
 module holder_downer(){
     difference(){
     useful_module(); 
     translate([wr_l,0,0])cylinder(h = (t*1.008), r = t, center = true);
 }
}
module moth_sacrificer(){
    rotate([180,0,180]){
        rotate([270,90,0]){
            bed(l,w);
            endcap();
            side(1);      side(0);
            wing(1);      wing(0);
            proboscis_rest();
        }
    }
}
moth_sacrificer();
translate([ 0.00, H+c_h, 0.00 ])rotate([ 90.00, 270.00, 180.00 ]) holder_downer();