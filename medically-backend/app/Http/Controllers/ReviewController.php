<?php

namespace App\Http\Controllers;
use App\Models\Review;

use Illuminate\Http\Request;

class ReviewController extends Controller
{
    public function addReview(Request $request){

       


        $review = new Review;
        $review->user_id = $request->user_id;
        $review->doctor_id = $request->doctor_id;
        $review->review_text = $request->review_text;
        $review->rating = $request->rating;
        $review->save();

        $avg = Review::where('doctor_id',$request->doctor_id)->avg('rating');

        \DB::table('doctor_details')->where('doctor_id', $request->doctor_id)->update(array('rating' => $avg));
        
        return response()->json([
            "success" => true,
            'avg'=>$avg,
        ], 200);
    }

    public function getReviewsByDoctorID(Request $request){

        $reviews = Review::where('doctor_id',$request->doctor_id)->get();
        return response()->json([
            "success" => true,
            "reviews" => $reviews
        ], 200);
    }
}
