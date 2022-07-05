<?php

namespace App\Http\Controllers;

use App\Models\Doctor_detail;

use Illuminate\Http\Request;

class DoctorController extends Controller
{
 
    public function addDoctor(Request $request){

        $doctor = new Doctor_detail;

        $doctor->doctor_id = $request->doctor_id;
        $doctor->rating = 0;
        $doctor->channel_name = $request->channel_name;
        $doctor->channel_token = $request->channel_token;
        $doctor->bio = 'empty doctor bio';
        $doctor->category_id = $request->category_id;

        $doctor->save();

        return response()->json([
            "success" => true,
        ], 200);
    }
}
