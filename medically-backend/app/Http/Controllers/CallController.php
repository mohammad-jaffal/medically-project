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

    public function getCallsByUserID(Request $request){
        $calls = Call::all()->where('user_id',$request->user_id);
        return response()->json([
            "success" => true,
            "calls" => $calls
        ], 200);
    }
}
