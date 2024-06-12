<script lang="coffee">
</script>

<template lang="pug">
main
  a
    b i18
    i MarkDown &amp; YAML 命令行翻译工具
  a
    b i18n.site
    i 多语言纯静态建站框架
</template>

<style lang="stylus">
main
  display flex
  flex 1
  flex-wrap wrap
  padding 24px 0
  width 100%

a
  background linear-gradient(0, #f3f3f3, #fcfcfc 50%, #fff)
  border 1px solid #ccc
  color #333
  display block
  flex-direction column
  font-family h
  font-size 16px
  font-variation-settings 'wght' 400, 'BEVL' 10
  height 32px
  justify-content space-between
  margin 0 0 24px 24px
  padding 8px 48px 32px 16px
  position relative

  &:after
    background var(--svgNabla) 50% 50% / cover no-repeat
    content ''
    height 8px
    margin-top -4px
    opacity 0.5
    position absolute
    right 16px
    top 50%
    transform rotate(-90deg)
    transition all 0.3s
    width 8px

  &>i
    color #666

  &>i, &>b
    display block
    font-size 14px
    max-width 400px
    overflow hidden
    text-overflow ellipsis
    white-space nowrap

  &:hover
    border-color #666

    &>b
      font-variation-settings 'wght' 900, 'BEVL' 10

    &:after
      opacity 1

    &>i
      color #333

  &:active
    box-shadow #333 0 0 5px inset

i
  font-style normal
</style>

