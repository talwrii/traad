from setuptools import setup, find_packages

setup(
    name='traad',
    version='2.3.0',
    packages=find_packages(),

    # metadata for upload to PyPI
    author='Austin Bingham',
    author_email='austin.bingham@gmail.com',
    description='A JSON+HTTP server for the rope Python refactoring library.',
    license='MIT',
    keywords='refactoring',
    url='http://github.com/abingham/traad',

    entry_points={
        'console_scripts': [
            'traad = traad.server:main',
            ],
        },

    install_requires=[
        'rope',
    ],
    extras_require={
        'test': ['pytest', 'tox', 'webtest'],
    },
)
