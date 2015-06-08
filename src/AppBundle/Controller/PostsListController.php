<?php

/* freepost
 * http://freepo.st
 *
 * Copyright � 2014-2015 zPlus
 * 
 * This file is part of freepost.
 * freepost is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 * 
 * freepost is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
 * GNU General Public License for more details.
 * 
 * You should have received a copy of the GNU General Public License
 * along with freepost. If not, see <http://www.gnu.org/licenses/>.
 */

namespace AppBundle\Controller;

use Symfony\Bundle\FrameworkBundle\Controller\Controller;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\Security\Core\SecurityContextInterface;
use Symfony\Component\HttpFoundation\JsonResponse;
use Symfony\Component\HttpFoundation\Response;

use AppBundle\Entity\Community;

class PostsListController extends Controller
{
    // Retrieve posts
    public function postsAction($communityHashId, $sort = '')
    {
        $em = $this->getDoctrine()->getManager();
        $communityRepo = $em->getRepository('AppBundle:Community');
        $postRepo = $em->getRepository('AppBundle:Post');
        
        $user = $this->getUser();
        $community = $communityRepo->findOneByHashId($communityHashId);
        
        $sort = strtoupper($sort);
        
        switch ($sort)
        {
            case 'NEW':
                $posts = $postRepo->findNew($community, $user);
                break;
            default:
                $sort = 'HOT';
                $posts = $postRepo->findHot($community, $user);
                break;
        }
        
        return new JsonResponse(array(
            'html' =>   $this->renderView(
                            'AppBundle:Default:Etc/PostsList/list.html.twig',
                            array(
                                'community'     => $community,
                                'posts'         => $posts,
                                'postsSorting'  => $sort
                            )
                        )
        ));
    }
    
    // Retrieve HOT posts
    public function hotAction($communityHashId)
    {
        return $this->forward('AppBundle:PostsList:posts', array(
            'communityHashId' => $communityHashId,
            'sort'            => 'HOT',
        ));
    }
    
    // Retrieve NEW posts
    public function newAction($communityHashId)
    {
        return $this->forward('AppBundle:PostsList:posts', array(
            'communityHashId' => $communityHashId,
            'sort'            => 'NEW',
        ));
    }
    
}


