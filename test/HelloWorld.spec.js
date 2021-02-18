import { shallowMount } from '@vue/test-utils'
import HelloWorld from '@/src/components/HelloWorld.vue'

describe('HelloWorld', () => {
  test('calls testFunction correctly on mounted hook', () => {
    const testMethod = jest.spyOn(HelloWorld.options.methods, 'testFunction')
    shallowMount(HelloWorld)
    expect(testMethod).toHaveBeenCalledWith('hello')
  })
  test('all props (required and non-required, should be set', async () => {
    const wrapper = shallowMount(HelloWorld)
    await wrapper.setProps({ required: 50 })
    expect(wrapper.props('required')).toBe(50)
    expect(wrapper.props('optional')).toBe(30)
    expect(wrapper.vm.computedOptional).toBe(30)
  })
})
