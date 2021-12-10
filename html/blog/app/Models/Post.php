<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Post extends Model
{
    use HasFactory;

    // protected $table = 'posts';
    protected $appends = ['created_at_for_humans'];
    protected $withCount = ['comments'];
    public function comments(){
        return $this->hasMany(Comment::class);
    }

    public function getCreatedAtForHumansAttribute(){
        return $this->created_at->diffForHumans();
    }
}
