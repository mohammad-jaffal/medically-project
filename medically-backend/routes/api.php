<?php

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Route;
use App\Http\Controllers\JWTController;
use App\Http\Controllers\DoctorController;
use App\Http\Controllers\CategoryController;

Route::group(['middleware' => 'api'], function($router) {
    Route::post('/register', [JWTController::class, 'register']);
    Route::post('/login', [JWTController::class, 'login']);
    Route::post('/logout', [JWTController::class, 'logout']);
    Route::post('/refresh', [JWTController::class, 'refresh']);
    Route::post('/profile', [JWTController::class, 'profile']);
});

Route::group(['prefix'=>'admin'], function(){
    Route::post('/add-doctor-details', [DoctorController::class, 'addDoctorDetails']);
    Route::post('/make-doctor', [DoctorController::class, 'makeDoctor']);
    Route::post('/add-category', [CategoryController::class, 'addCategory']);

    
});



Route::get('/get-doctors', [DoctorController::class, 'getAllDoctors']);
Route::get('/get-categories', [CategoryController::class, 'getCategories']);