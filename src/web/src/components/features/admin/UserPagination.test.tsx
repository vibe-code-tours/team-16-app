import { describe, it, expect, vi } from 'vitest'
import { render, screen, fireEvent } from '@testing-library/react'
import { UserPagination } from './UserPagination'

describe('UserPagination', () => {
  it('returns null when total is 0', () => {
    const { container } = render(
      <UserPagination page={1} pageSize={25} total={0} onPageChange={vi.fn()} />
    )
    expect(container.innerHTML).toBe('')
  })

  it('shows correct range text', () => {
    render(
      <UserPagination page={1} pageSize={25} total={50} onPageChange={vi.fn()} />
    )
    expect(screen.getByText('Showing 1–25 of 50 users')).toBeInTheDocument()
  })

  it('previous button disabled on page 1', () => {
    render(
      <UserPagination page={1} pageSize={25} total={50} onPageChange={vi.fn()} />
    )

    // Previous button is the first Button (ghost variant with ChevronLeft)
    const prevButton = screen.getAllByRole('button')[0]
    expect(prevButton).toBeDisabled()
  })

  it('next button disabled on last page', () => {
    render(
      <UserPagination page={2} pageSize={25} total={50} onPageChange={vi.fn()} />
    )

    // Next button is the last Button (ghost variant with ChevronRight)
    const buttons = screen.getAllByRole('button')
    const nextButton = buttons[buttons.length - 1]
    expect(nextButton).toBeDisabled()
  })

  it('renders page numbers', () => {
    render(
      <UserPagination page={1} pageSize={25} total={100} onPageChange={vi.fn()} />
    )

    expect(screen.getByText('1')).toBeInTheDocument()
    expect(screen.getByText('2')).toBeInTheDocument()
    expect(screen.getByText('3')).toBeInTheDocument()
    expect(screen.getByText('4')).toBeInTheDocument()
  })

  it('clicking page calls onPageChange', () => {
    const onPageChange = vi.fn()
    render(
      <UserPagination page={1} pageSize={25} total={100} onPageChange={onPageChange} />
    )

    fireEvent.click(screen.getByText('2'))
    expect(onPageChange).toHaveBeenCalledWith(2)
  })
})
