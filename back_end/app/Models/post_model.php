<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class post_model extends Model
{
    use HasFactory;
    public $timestamps = false;
    protected $table='post';
    protected $primarykey='id';
    protected $fillable=[
        'title',
        'description',
        'image',
        'user_id',
    ];
    public function user(){
        return $this->belongsTo(User::class);
    }
    public function Comment(){
        return $this->hasMany(comment_model::class,'post_id');
    }
    public function like(){
        return $this->hasMany(like_model::class,'post_id');
    }
    public function favorite(){
        return $this->hasMany(favorite::class,'post_id');
    }
}
