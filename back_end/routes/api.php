<?php

use App\Http\Controllers\api\auth_controller;
use App\Http\Controllers\api\comment_controller;
use App\Http\Controllers\api\favorite_controller;
use App\Http\Controllers\api\like_controller;
use App\Http\Controllers\api\post_controller;
use App\Http\Controllers\api\user_controller;
use Illuminate\Support\Facades\Route;
Route::controller(auth_controller::class)->group(function(){
    Route::post('/register','register');
    Route::post('/login','login');
});
Route::group(['middleware' => 'auth:sanctum'],function(){
    // Route::post('/logout', [auth_controller::class, 'logout']);
    Route::get('/user/get',[user_controller::class,'index']);
    Route::get('/post/get',[post_controller::class,'index']);
    Route::post('/post/store',[post_controller::class,'store']);
    Route::get('/post/delete',[post_controller::class,'delete']);
    Route::get('/history/get',[post_controller::class,'history']);
    Route::get('/like',[like_controller::class,'like']);
    Route::get('/favorite/get',[favorite_controller::class,'index']);
    Route::get('/favorite',[favorite_controller::class,'favorite_unfavorite']);
    Route::controller(comment_controller::class)->group(function(){
        Route::get('/comment/get','index');
        Route::get('/comment/store','store');
        Route::get('/comment/delete','delete');
        Route::post('/comment/update','update');
    });
});