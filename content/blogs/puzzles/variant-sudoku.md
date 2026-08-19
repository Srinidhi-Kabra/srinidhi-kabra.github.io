---
date: '2026-08-19T09:26:23+05:30'
draft: true
title: 'Constructing a Hard Variant Sudoku'
description: 'I recently constructed a really difficult variant sudoku. In this blog I show a look-behind-the-scenes and discuss the work that actually went into it.'
tags : 
    - sudoku
category : 
series:
showWordCount: true
showReadingTime: true
---

<div style="text-align: justify; font-size: 1rem;">
<style>
  /* This will only apply to elements on this exact page */
  .prose, article, .max-w-prose {
      max-width: 75rem !important;
  }
</style>

For the last few years, solving variant sudokus has been a part of my daily routine. Most people are familiar with the 'standard' sudoku game - it is where you place the digits 1-9 exactly once in each row, column and 3x3 box placed inside of a 9x9 grid. Although few are aware that there are variants of this game. Existence of variants may not be surprising, afterall, any game has variants. But perhaps what is surprising, is the popularity of variant sudokus in certain circles. There are entire communities dedicated to the art of solving and constructing these variants, something that people in these circles take incredibly seriously. As someone who is deeply immersed into this world, I want to show you what this world looks like on the inside. This is one of those blogs that I intended on writing for a long time but never got around to it, but finally, the time is here!

## 1. Introduction - Sudokus as Constraints on a Square Grid

<div style="display: grid; grid-template-columns: 1fr 280px; gap: 40px; align-items: start;">

<div>
Let us start by reviewing a few things you (hopefully) have seen before. Even if you haven't, it should be easy to follow through this section. So what is a sudoku? This is a classic Japanese puzzle. Figure 1 depicts a 9x9 grid with the following features- the grid is divided into nine 3 by 3 boxes consisting of 9 cells each. Each row and column also contain 9 cells. The goal of this puzzle is to fill the grid with the digits 1 through 9 such that no digit is repeated in any row, column or 3x3 box. That's the only restriction. As a direct consequence we can also conclude that each row, column and 3x3 box must contain each of the digits 1-9 exactly once. Give the sudoku in Figure 1 a try, it is an easy one! Such sudokus are what we would call classical sudokus, where the only constraint is to place the digits according to above. The digits that are already present in the bold black colour are what we call given digits. Our solution must be compatible with these digits, we aren't allowed to edit them. If you want to practice and learn more about classical sudokus, there are numerous websites where you can solve and learn sudoku techniques, one that I would highly recommend is <a href="https://sudoku.coach"> Sudoku Coach</a>.
</div>

<div>
<figure>
    <img src="/blogs/sudoku/figure1-classical-easy.png"
         alt="Variant Sudoku"
         style="width: auto; height: auto;">
    <figcaption>
        <a href="https://sudoku.coach/en/play/000070200000000384306850790905004800070500400200100065600000100408901003500300049" target="_blank" rel="noopener">
            Fig 1 : An easy classical sudoku
        </a>
    </figcaption>
</figure>
</div>
</div> 

An important question here, is whether or not the arrangement of digits is in fact unique i.e. if there's only one solution to the given grid. In general, a particular arrangement of digits need not have a single possible solution. Say, you only put one digit in the entire grid - then of course, there are a multitude of ways in which you can fill in rest of the grid. The above sudoku, as you can check, has one and only solution. In such a case then we can talk about not *a solution* but *the solution*. We shall restrict ourselves with the consideration of sudokus which have a unique solution. 

A different way to think of this is as following - you are given a square 9x9 grid and this grid then has a unique configuration of digits in it, where the digits are subjected to some constraint. In case of classical sudokus, these constraints are,
- every row contains only one copy of each digit
- every column contains only one copy of each digit
- each 3x3 box in the grid contains only one copy of each digit
- given digits in the grid

Thus a sudoku can be characterised as a certain configuration of digits subject to some constraint. If the sudoku has only above constraints then we call it a classical sudoku. But there's no reason that sudoku grid cannot contain some other constraints. For example, in addition to the above rules, I can require that certain cells inside the sudoku contain consecutive digits - this is depicted in Figure 2. 




</div>