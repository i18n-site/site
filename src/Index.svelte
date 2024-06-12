<template lang="pug">
Topbar
  TopbarR
<svelte:component this="{M}"/>
</template>

<style lang="stylus"></style>

<script lang="coffee">
> @8p/nav:
  @8p/h404:H404
  @8p/topbar:Topbar
  @8p/wait:Wait
  svelte > tick
  ./TopbarR.svelte
  x/route.js
  x/Match.js

M = Wait

page = (m)=>
  M = Wait
  await tick()
  M = m
  return

match = Match(
  page
  =>
    M = H404
    return
)

route (url)=>
  match url
  return

onI18n =>
  match location.pathname.slice(1)
  return
</script>

