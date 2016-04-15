__author__ = 'dale mcdiarmid'

def merge_config(config={}, key=''):
    return {key:config}

class FilterModule(object):
    def filters(self):
        return {'merge_config': merge_config}