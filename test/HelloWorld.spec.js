import { shallowMount } from '@vue/test-utils'
import HelloWorld from '@/src/components/HelloWorld.vue'

describe('HelloWorld', () => {
  test('calls testFunction correctly on mounted hook', () => {
    const testMethod = jest.spyOn(HelloWorld.options.methods, 'testFunction')
    shallowMount(HelloWorld)
    expect(testMethod).toHaveBeenCalledWith('hello')
  })
})
