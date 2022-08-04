<?php

namespace App\Http\Controllers;

use App\Models\Doctor_detail;
use App\Models\User;
use Illuminate\Http\Request;

class DoctorController extends Controller
{
 
    

    public function getAllDoctors(Request $request){

        $doctors = Doctor_detail::join('users', 'users.id', '=', 'doctor_details.doctor_id')->get(['doctor_details.*', 'users.*']);

        return response()->json([
            "success" => true,
            "doctors" => $doctors
        ], 200);
    }


    public function acceptDoctor(Request $request){

        User::where('id', $request->user_id)->update(array('type' => 2));

        return response()->json([
            "success" => true,
        ], 200);
    }

    public function declineDoctor(Request $request){

        User::where('id', $request->user_id)->update(array('type' => 1));

        return response()->json([
            "success" => true,
        ], 200);
    }

    public function addDoctorDetails(Request $request){

        $doctor = new Doctor_detail;

        $doctor->doctor_id = $request->doctor_id;
        $doctor->rating = 0;
        $doctor->channel_name = $request->channel_name;
        $doctor->channel_token = $request->channel_token;
        $doctor->bio = 'empty doctor bio';
        $doctor->domain_id = $request->domain_id;
        $doctor->online = 0;

        $doctor->save();

        return response()->json([
            "success" => true,
        ], 200);
    }

    public function getDoctor(Request $request){

        $doctor = User::join('doctor_details', 'doctor_details.doctor_id', '=', 'users.id')
        ->where('users.id', $request->doctor_id)
        ->get();
        return response()->json([
            "success" => true,
            "doctor" => $doctor
        ], 200);
    }

    public function setStatus(Request $request){

        Doctor_Detail::where('doctor_id', $request->doctor_id)->update(array('online' => $request->status));

        return response()->json([
            "success" => true,
        ], 200);
    }

    public function updateBio(Request $request){

        Doctor_Detail::where('doctor_id', $request->doctor_id)->update(array('bio' => $request->bio));

        return response()->json([
            "success" => true,
        ], 200);
    }
}
