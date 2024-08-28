<?php

namespace App\Http\Controllers\api;
use Illuminate\Support\Str;
use App\Http\Controllers\Controller;
use App\Models\post_model;
use Illuminate\Http\Request;

class post_controller extends Controller
{
    public function index(Request $request)
    {
        $post = post_model::with('user:id,name,image,email')->withCount('Comment','like')
        ->with('like', function ($like) {
            return $like->where('user_id', auth()->user()->id)
                ->select('id', 'user_id', 'post_id')->get();
        })
        ->with('favorite', function ($favorite) {
            return $favorite->where('user_id',Auth()->user()->id)
                ->select('id', 'user_id', 'post_id')->get();
        })->get();
        return response()->json([
            'post' => $post,
            'status' => true,
        ]);
    }
    public function store(Request $request){
        // $request->validate([
        //     'title' => 'required|string|max:255',
        //     'description' => 'required|string',
        //     'image' => 'nullable|image|mimes:jpeg,png,jpg,gif|max:2048',
        // ]);
        if ($request->hasFile('image')) {
            echo auth()->user()->id;
            $image = $request->file('image');
            $imageName = Str::random(100) .'.'. $image->getClientOriginalExtension();
            $image->move(public_path('file/post/image'), $imageName);
            $post=post_model::create([
                'title'=>$request->title,
                'description'=>$request->description,
                'image'=> $imageName,
                'user_id'=> auth()->user()->id,
            ]);
            if($post){
                echo '111111';
            }
        }else{
            echo '2222222';
        }
    }
    public function history(Request $request){
        $post = post_model::with('user:id,name,image,email')->withCount('Comment','like')
        ->with('like', function ($like) {
            return $like->where('user_id', auth()->user()->id)
                ->select('id', 'user_id', 'post_id')->get();
        })
        ->with('favorite', function ($favorite) {
            return $favorite->where('user_id',Auth()->user()->id)
                ->select('id', 'user_id', 'post_id')->get();
        })->where('user_id',$request->user_id)->get();
        return response()->json([
            'post' => $post,
            'status' => true,
        ]);
    }
    public function delete(Request $request){
        $post =post_model::find( $request->id );
        if($post->delete()){
            return response()->json([
                "status"=>true,
                "message"=>"Delete sucessfull...",
            ]);
        }
    }
}
