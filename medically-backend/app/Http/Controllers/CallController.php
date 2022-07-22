<?php

namespace App\Http\Controllers;
use App\Models\Call;

use Illuminate\Http\Request;

class CallController extends Controller
{
    public function addCall(Request $request){
        
        $call = new Call;
        $call->user_id = $request->user_id;
        $call->doctor_id = $request->doctor_id;
        $call->duration = $request->duration;
        $call->save();

        return response()->json([
            "success" => true,
        ], 200);
    }
    // $doctor = \DB::table('users')
    //     ->join('doctor_details', 'doctor_details.doctor_id', '=', 'users.id')
    //     ->where('users.id', $request->doctor_id)
    //     ->get();


    public function getCallsByUserID(Request $request){
        $calls = \DB::table('calls')
        ->join('users', 'users.id', '=', 'calls.doctor_id')
        ->where('calls.user_id', $request->user_id)
        ->select('calls.*','users.name' ,'users.profile_picture')
        ->orderBy('calls.created_at','DESC')
        ->get();
        return response()->json([
            "success" => true,
            "calls" => $calls
        ], 200);
    }

    public function getCallsByDoctorID(Request $request){
        $calls = \DB::table('calls')
        ->join('users', 'users.id', '=', 'calls.user_id')
        ->where('calls.doctor_id', $request->doctor_id)
        ->select('calls.*', 'users.name' ,'users.profile_picture')
        ->get();
        return response()->json([
            "success" => true,
            "calls" => $calls
        ], 200);
    }
}
