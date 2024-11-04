<template lang="pug">
Topbar
  TopbarR
<svelte:component this="{M}"/>
</template>

<style lang="stylus"></style>

<script lang="coffee">
> ./TopbarR.svelte
  @8p/h404:H404
  @8p/nav:
  @8p/topbar:Topbar
  @8p/wait:Wait
  svelte > tick
  x/Match.js
  x/route.js:@ > goto

M = Wait

page = (m)=>
  M = Wait
  await tick()
  M = m
  return

match = Match(
  page
  =>
    if location.pathname.slice(1) == ''
      goto _NAV[0][0]
      return
    M = H404
    return
)

onI18n =>
  match location.pathname.slice(1)
  return

route (url)=>
  match url
  return
</script>

